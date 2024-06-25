import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/data/model/item_model.dart';

const String gallery = 'assets/images/gallery.png';
const String camera = 'assets/images/camera.png';

void constSnackBar({String? title, String? message}) {
  Get.snackbar("", "",
      titleText: title != null
          ? Text(
              title,
              style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
            )
          : null,
      messageText: message != null
          ? Text(
              message,
              style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
            )
          : null,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(138, 66, 66, 66));
}

Widget customLoadingIndicator() {
  return Container(
      width: Get.size.shortestSide,
      height: Get.size.longestSide,
      color: const Color.fromARGB(193, 255, 255, 255),
      child: const Center(
        child: CircularProgressIndicator(),
      ));
}

String convertQuantityToString(Quantity quantity) {
  switch (quantity) {
    case Quantity.gm:
      return "gm";
    case Quantity.kg:
      return "Kg";
    case Quantity.dozen:
      return "dozen";
    case Quantity.l:
      return "L";
    case Quantity.ml:
      return "ml";
  }
}

String convertCategoryToString(Category category) {
  switch (category) {
    case Category.bakery:
      return "Bakery";
    case Category.beverages:
      return "Beverages";
    case Category.dairy:
      return "Dairy";
    case Category.fruits_vegetables:
      return "Fruits & Vegetables";
    case Category.meat:
      return "Meat";
    case Category.grain_pulses:
      return "Grains & Pulses";
    case Category.snacks:
      return "Snacks";
    case Category.spices:
      return "Spices";
    case Category.other:
      return "Other";
    case Category.dryFruits:
      return "Dry Fruits";
  }
}
