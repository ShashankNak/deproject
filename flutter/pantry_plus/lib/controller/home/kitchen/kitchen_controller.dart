import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_plus/api/gemini/key.dart';
import 'package:pantry_plus/api/web_crawler.dart';

import '../../../api/gemini/gemini_api.dart';

class KitchenController extends GetxController {
  var result = ("").obs;
  RxList<String> titles = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setApiKey();
  }

  void openBarcodeScanner(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    // final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      log("Barcode: ${barcode.rawValue}");
      result(barcode.rawValue);
      update();
      if (result.value != "") {
        await WebCrawler.getProductDetail(result.value).then((value) {
          titles(value);
          update();
          Get.back();
        });
      }
    }
  }

  List<Widget> tabs = [
    const Tab(
      child: Text("Fridge"),
    ),
    const Tab(
      child: Text("Pantry"),
    ),
    const Tab(
      child: Text("Freezer"),
    ),
    const Tab(
      child: Text("Spices"),
    ),
    const Tab(
      child: Text("Beverages"),
    ),
    const Tab(
      child: Text("Other"),
    ),
    const Tab(
      icon: Icon(Icons.add),
    ),
  ];

  //for picking and compressing image
  void imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);
    if (photo != null) {
      log("image path: ${photo.path}");
      log("image size: ${await photo.length()}");
      getGeminiResponse(photo.path);
    }
    return;
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

  Future<void> setApiKey() async {
    final key =
        await SecretLoader(secretPath: "lib/api/gemini/secret.json").load();
    log(key.apikey);
    Gemini.init(apiKey: key.apikey, enableDebugging: true);
  }

  void getGeminiResponse(String img) async {
    final value = await GeminiApi.getGeminiResponse(img);
    log(value);
  }
}
