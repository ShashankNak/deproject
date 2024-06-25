import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_plus/api/firebase/inventory_database.dart';
import 'package:pantry_plus/api/gemini/key.dart';
import 'package:pantry_plus/api/web_crawler.dart';
import 'package:pantry_plus/data/model/item_model.dart';
import 'package:pantry_plus/data/model/user_selected_ingredients_model.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/components/model_generated_card.dart';
import 'package:pantry_plus/utils/const.dart';

import '../../../api/gemini/gemini_api.dart';

class KitchenController extends GetxController {
  var result = ("").obs;
  RxList<String> titles = <String>[].obs;
  var isLoading = false.obs;
  var selectedCategory = Category.fruits_vegetables.obs;

  RxList<UserSelectedIngredientsModel> inventory =
      <UserSelectedIngredientsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    log("auth: ${FirebaseAuth.instance.currentUser!.uid}");
    setApiKey();
  }

  void deleteInventoryItem(UserSelectedIngredientsModel item) {
    try {
      isLoading(true);
      update();
      InventoryDatabase.deleteInventory(item);
      update();
      Get.snackbar("${item.itemModel.itemName} is removed!", "",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Failed to remove ${item.itemModel.itemName}", "",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      update();
    }
  }

  void openBarcodeScanner(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;

    isLoading(true);
    update();
    // final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      log("Barcode: ${barcode.rawValue}");
      result(barcode.rawValue);
      update();
      if (result.value != "") {
        await WebCrawler.getProductDetail(result.value).then((value) {
          titles(value);
          update();
          isLoading(false);
          update();
          Get.off(() => const ModelGeneratedScreen());
        });
      }
    }
  }

  void setCategory(Category category) {
    selectedCategory(category);
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

  Future<void> setApiKey() async {
    final key =
        await SecretLoader(secretPath: "assets/keys/secret.json").load();
    log(key.apikey);
    Gemini.init(apiKey: key.apikey, enableDebugging: true);
  }

  void getGeminiResponse() async {
    final img = await showBottomSheetForImage();
    String value = "";
    Get.to(() => const ModelGeneratedScreen());
    isLoading(true);
    update();

    //calling api of gemini for image recognition
    value = await GeminiApi.getGeminiResponse(img);

    isLoading(false);
    update();
    log(value);
    titles([value]);
    update();
  }

  String expiryDateFormatter(String date) {
    //show the expiry date on the front end as is format of second(s), minute(m), hour(h), days(D),Month(M),years(Y)
    //subtract the date from the current date and show the difference
    DateTime currentDate = DateTime.now();
    DateTime expiryDate =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(date) ?? 0);

    Duration difference = expiryDate.difference(currentDate);

    int seconds = difference.inSeconds;
    int minutes = difference.inMinutes;
    int hours = difference.inHours;
    int days = difference.inDays;
    int months = (expiryDate.year - currentDate.year) * 12 +
        expiryDate.month -
        currentDate.month;
    int years = expiryDate.year - currentDate.year;

    String formattedExpiryDate = '';
    if (years > 0) {
      formattedExpiryDate = '$years Y ';
    } else if (months > 0) {
      formattedExpiryDate = '$months M ';
    } else if (days > 0) {
      formattedExpiryDate = '$days D ';
    } else if (hours > 0) {
      formattedExpiryDate = '$hours h ';
    } else if (minutes > 0) {
      formattedExpiryDate = '$minutes m ';
    } else if (seconds > 0) {
      formattedExpiryDate = '$seconds s';
    } else {
      formattedExpiryDate = 'Expired';
    }

    return formattedExpiryDate;
  }
}
