import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pantry_plus/controller/firebase/firebase_database.dart';
import 'package:pantry_plus/data/model/user_details_model.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final fD = FirebaseDatabase();
  var editMode = false.obs;
  Rx<UserDetailsModel> user = UserDetailsModel(
    mId: '',
    fId: '',
    name: '',
    email: '',
    imageUrl: '',
    birthdate: '',
    gender: Gender.none,
    height: '',
    weight: '',
    preference: '',
  ).obs;

  var isLoading = false.obs;
  var nameEC = TextEditingController().obs;
  var dobEC = TextEditingController().obs;
  var genderEC = TextEditingController().obs;
  var heightEC = TextEditingController().obs;
  var weightEC = TextEditingController().obs;
  var preferences = MultiSelectController<int>().obs;

  var newImage = "".obs;

  List<DropdownMenuEntry<Gender>> get entries => [
        for (var gender in Gender.values.where((g) => g != Gender.none))
          DropdownMenuEntry<Gender>(
            value: gender,
            label: gender.toString().split(".").last,
          ),
      ];

  final entry = {
    "Vegetarian": 1,
    "Non-Vegetarian": 2,
    "Vegan": 3,
    "Jain": 4,
    "Gluten-Free": 5,
    "Lactose-Free": 6,
  };

  void initializeControllers() {
    //name, dob and gender
    nameEC.update((val) => val!.text = user.value.name);
    newImage(user.value.imageUrl);
    if (user.value.birthdate != "" && user.value.birthdate.isNotEmpty) {
      dobEC.update((val) => val!.text = DateFormat('dd-MM-yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(user.value.birthdate)!)));
    }

    genderEC.update((val) {
      final gender = user.value.gender.toString().split(".").last;
      if (gender != 'none') {
        val!.text = gender;
      }
    });
    newImage(user.value.imageUrl);
    update();

    //height and weight
    heightEC.update((val) => val!.text = user.value.height);
    weightEC.update((val) => val!.text = user.value.weight);

    //preferences
    preferences.update((val) {
      val!.setOptions(const [
        ValueItem(label: 'Vegetarian', value: 1),
        ValueItem(label: 'Non-Vegetarian', value: 2),
        ValueItem(label: 'Vegan', value: 3),
        ValueItem(label: 'Jain', value: 4),
        ValueItem(label: 'Gluten-Free', value: 5),
        ValueItem(label: 'Lactose-Free', value: 6),
      ]);
    });
    if (user.value.preference != "") {
      List<ValueItem<int>> selectedOptions = user.value.preference
          .split(" ")
          .map((items) => ValueItem(label: items, value: entry[items]))
          .toList();
      preferences.update((val) => val!.setSelectedOptions(selectedOptions));
      update();
    }

    log("controller initailized");
  }

  @override
  void onInit() {
    getUserDetails();
    log(user.value.gender.toString());
    super.onInit();
  }

  Future<void> getUserDetails() async {
    isLoading(true);
    update();
    final data = await FirebaseDatabase.getUserDetails2(
        FirebaseDatabase.firebaseAuth.currentUser!.uid);

    if (!data.exists || data.data() == null || data.data()!.isEmpty) {
      log("No data found");
      isLoading(false);
      update();
      return;
    }
    final userData = UserDetailsModel.fromJson(data.data()!);
    user(userData);
    initializeControllers();

    update();

    isLoading(false);
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // This ensures the user can't pick a future date as their birthdate.
    );
    if (picked != null && picked != DateTime.now()) {
      user.update(
        (val) {
          val!.birthdate = picked.millisecondsSinceEpoch.toString();
        },
      );
      dobEC
          .update((val) => val!.text = DateFormat('dd-MM-yyyy').format(picked));
      log(user.value.birthdate);
      update();
    }
  }

  Future<void> updateProfile() async {
    isLoading(true);
    update();
    try {
      if (newImage.value != user.value.imageUrl) {
        final image = await uploadImageToFB(newImage.value);
        newImage(image);
        update();
        user.update((val) {
          val!.imageUrl = newImage.value;
        });
      }

      user.update((val) {
        val!.name = nameEC.value.text.trim();
        val.gender = genderEC.value.text == "male"
            ? Gender.male
            : genderEC.value.text == "female"
                ? Gender.female
                : genderEC.value.text == "other"
                    ? Gender.other
                    : Gender.none;
        val.height = heightEC.value.text.trim();
        val.weight = weightEC.value.text.trim();
        val.preference = preferences.value.selectedOptions
            .map((e) => e.label)
            .toList()
            .join(" ");
      });
      log(user.value.toJson().toString());
      FirebaseDatabase.storeUserDetails(user.value);
      log("Value Changed");
    } catch (e) {
      log("value not changed");
    } finally {
      isLoading(false);
      update();
    }
  }

  //for picking and compressing image

  void imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);
    if (photo != null) {
      newImage(photo.path);
      update();
      return;
    }
    return;
  }

  Future<String> uploadImageToFB(String path) async {
    final ext = path.split(".").last;

    final ref = FirebaseDatabase.storage.ref().child(
        'profile_pictures/${FirebaseDatabase.firebaseAuth.currentUser!.uid}.$ext');
    try {
      //storage file in ref with path
      //uploading image
      log("message..........");
      final uploadTask =
          ref.putFile(File(path), SettableMetadata(contentType: 'image/$ext'));
      final snapshot = await uploadTask.whenComplete(() {});
      final img = await snapshot.ref.getDownloadURL();
      log(img);
      return img;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void showBottomSheetForImage() {
    Get.bottomSheet(
      Container(
        color: Get.theme.colorScheme.primary,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () {
                imagePicker(ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                imagePicker(ImageSource.camera);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
