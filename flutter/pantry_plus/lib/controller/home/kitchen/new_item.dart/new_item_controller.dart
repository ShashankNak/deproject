import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/item_model.dart';

class NewItemController extends GetxController {
  var isLoading = false.obs;
  var dateController = TextEditingController().obs;
  final formkey = GlobalKey<FormState>();

  var newItem = ItemModel(
    itemId: "",
    itemName: "",
    description: "",
    itemKeywords: [],
    itemImage: "",
    itemCategory: Category.fruits_vegetables,
    quantity: "",
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
    newItem.update((val) {
      val!.itemImage = img;
    });
    update();
  }

  List<Widget> tabs = List.generate(
      Category.values.length,
      (index) => Tab(
            text: Category.values[index].toString().split(".").last.capitalize!,
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
    newItem.update((val) {
      val!.itemId = DateTime.now().millisecondsSinceEpoch.toString();
    });
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    log(newItem.toJson().toString());
    Get.back();
    Get.snackbar(newItem.value.itemName, "Added to your Inventory!",
        snackPosition: SnackPosition.BOTTOM);
  }
}
