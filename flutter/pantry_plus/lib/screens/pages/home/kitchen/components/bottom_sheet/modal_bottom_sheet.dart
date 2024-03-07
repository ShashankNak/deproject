import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../utils/const.dart';

//for picking and compressing image

void imagePicker(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: source);
  if (photo != null) {
    log("image path: ${photo.path}");
    log("image size: ${await photo.length()}");
  }
  return;
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: Get.theme.colorScheme.secondary,
    builder: (context) {
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            top: Get.size.height / 40, bottom: Get.size.height / 40),
        children: [
          Text(
            "Pick Profile Picture",
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontSize: Get.size.height / 40,
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.onSecondary,
            ),
          ),
          SizedBox(
            height: Get.size.height / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  shape: const CircleBorder(),
                  fixedSize: Size(
                    Get.size.width / 4,
                    Get.size.width / 4,
                  ),
                ),
                onPressed: () {
                  imagePicker(ImageSource.gallery);

                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  alignment: Alignment.center,
                  gallery,
                  fit: BoxFit.fill,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  fixedSize: Size(
                    Get.size.width / 4,
                    Get.size.width / 4,
                  ),
                ),
                onPressed: () {
                  imagePicker(ImageSource.camera);

                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  alignment: Alignment.center,
                  camera,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ],
      );
    },
  );
}
