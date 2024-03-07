import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/authapi/auth_api.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/controller/home/profile/profile_controller.dart';
import 'package:pantry_plus/screens/pages/home/dining/dining_screen.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_screen.dart';
import 'package:pantry_plus/screens/pages/home/planner/planner_screen.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_screen.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_screen.dart';
import 'package:pantry_plus/screens/pages/start_screen/start_screen.dart';

class HomeController extends GetxController {
  var selectedPage = (0).obs; //selected screen number
  var isLoading = false.obs;
  final List<Widget> pages = ([
    const KitchenScreen(),
    const RecipeScreen(),
    const PlannerScreen(),
    const DiningScreen(),
    const ProfileScreen(),
  ]);

  final AuthApi auth = AuthApi();

  @override
  void onInit() {
    super.onInit();
    // auth.me = auth.firebaseAuth.currentUser!;
    log("User Credentials stored");
  }

  //function for changing screen
  void changeScreen(int value) {
    selectedPage(value);
    update();

    switch (value) {
      case 0:
        Get.delete<ProfileController>();
        update();
        log("Kitchen Screen");
        return;
      case 1:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        update();
        log("Recipe Screen");
        return;
      case 2:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        update();
        log("Planner Screen");
        return;
      case 3:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        update();
        log("Dining Screen");
        return;
      case 4:
        Get.delete<KitchenController>();
        update();
        log("Profile Screen");
        return;
    }

    log(value.toString());
  }

  void signOut() async {
    isLoading(true);
    update();

    if (await auth.signOut()) {
      isLoading(false);
      update();
      Get.offUntil(
          GetPageRoute(
              page: () => const StartScreen(),
              transition: Transition.leftToRightWithFade),
          (route) => false);
      Get.snackbar("Successfull logging out", "Please come again soon!");
      return;
    }
    Get.snackbar("Error while logging out", "Try Again Later");
    isLoading(false);
    update();
  }
}
