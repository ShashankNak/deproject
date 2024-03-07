import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
