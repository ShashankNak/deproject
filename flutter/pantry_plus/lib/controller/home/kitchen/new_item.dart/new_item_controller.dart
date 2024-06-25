import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pantry_plus/data/model/user_selected_ingredients_model.dart';
import 'package:pantry_plus/utils/const.dart';

import '../../../../api/firebase/firebase_database.dart';
import '../../../../api/firebase/inventory_database.dart';
import '../../../../data/model/item_model.dart';

class NewItemController extends GetxController {
  var isLoading = false.obs;
  var dateController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  final formkey = GlobalKey<FormState>();
  var storedImg = "".obs;

  var newItem = ItemModel(
    itemId: "",
    itemName: "",
    description: "",
    itemKeywords: [],
    itemImage: "",
    itemCategory: Category.fruits_vegetables,
    quantityType: Quantity.kg,
    expiryDate: "",
  ).obs;

  Future<void> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    initialDate ??= DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    final date = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
    log(date.millisecondsSinceEpoch.toString());
    newItem.update((val) {
      val!.expiryDate = date.millisecondsSinceEpoch.toString();
    });
    dateController.update(
        (val) => val!.text = DateFormat('dd-MM-yyyy hh:mm a').format(date));
    update();
  }

  void getNewItemImage() async {
    final img = await showBottomSheetForImage();
    storedImg(img);
    newItem.update((val) {
      val!.itemImage = img;
    });
    update();
  }

  List<Widget> tabs = List.generate(
      Category.values.length,
      (index) => Tab(
            text: convertCategoryToString(Category.values[index]),
          ));

  //for picking and compressing image
  Future<String> imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);
    if (photo != null) {
      log("image path: ${photo.path}");
      log("image size: ${await photo.length()}");
      return photo.path;
    }
    return "";
  }

  Future<String> showBottomSheetForImage() async {
    String photo = await Get.bottomSheet(
      Container(
        color: Get.theme.colorScheme.primary,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () async {
                final pic = await imagePicker(ImageSource.gallery);
                Get.back(result: pic);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                final pic = await imagePicker(ImageSource.camera);
                Get.back(result: pic);
              },
            ),
          ],
        ),
      ),
    );
    return photo;
  }

  Future<void> addNewItem() async {
    final isValid = formkey.currentState!.validate();
    if (newItem.value.itemImage == "") {
      Get.snackbar(
        "",
        "",
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Error: Upload an Image!",
          style: Get.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        ),
      );
      return;
    }
    if (!isValid) {
      return;
    }
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    log(newItem.toJson().toString());

    isLoading(true);
    update();

    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      uploadImageToFB(newItem.value.itemImage, id).then((value) async {
        newItem.update((val) async {
          val!.itemImage = value;
          val.itemId = id;
        });
        update();

        UserSelectedIngredientsModel userSelectedIngredientsModel =
            UserSelectedIngredientsModel(
          itemModel: newItem.value,
          quantity: quantityController.value.text.trim(),
          expiryDate: newItem.value.expiryDate,
        );

        await InventoryDatabase.storeInventory(userSelectedIngredientsModel);
        Get.back();

        Get.snackbar(newItem.value.itemName, "Added to your Inventory!",
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
      });
    } catch (e) {
      isLoading(false);
      update();
      Get.snackbar("Something went wrong", "while uploading to Database!",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
  }

  Future<String> uploadImageToFB(String path, String id) async {
    final ext = path.split(".").last;

    final ref = FirebaseDatabase.storage.ref().child(
        'userIngredients/${FirebaseDatabase.firebaseAuth.currentUser!.uid}/$id.$ext');
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
}
