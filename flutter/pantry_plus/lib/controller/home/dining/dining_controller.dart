import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
// import 'dart:developer';

class DiningController extends GetxController {
  var hCont = Get.find<HomeController>();

  var userLocation = <double>[0.0, 0.0].obs;
  @override
  void onInit() {
    super.onInit();
  }
}
