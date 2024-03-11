import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_plus/api/gemini/key.dart';
import 'package:pantry_plus/api/web_crawler.dart';
import 'package:pantry_plus/data/model/item_model.dart';

import '../../../api/gemini/gemini_api.dart';

class KitchenController extends GetxController {
  var result = ("").obs;
  RxList<String> titles = <String>[].obs;
  var isLoading = false.obs;

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

  Future<void> setApiKey() async {
    final key =
        await SecretLoader(secretPath: "assets/keys/secret.json").load();
    log(key.apikey);
    Gemini.init(apiKey: key.apikey, enableDebugging: true);
  }

  void getGeminiResponse() async {
    final img = await showBottomSheetForImage();
    final value = await GeminiApi.getGeminiResponse(img);
    log(value);
  }
}
