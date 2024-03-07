import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_plus/api/web_crawler.dart';

class KitchenController extends GetxController {
  var result = ("").obs;
  RxList<String> titles = <String>[].obs;
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
}
