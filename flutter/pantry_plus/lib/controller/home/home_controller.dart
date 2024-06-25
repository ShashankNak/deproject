import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/authapi/auth_api.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/controller/home/profile/profile_controller.dart';
import 'package:pantry_plus/controller/home/recipe/recipe_controller.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';
import 'package:pantry_plus/screens/pages/home/dining/dining_screen.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_screen.dart';
import 'package:pantry_plus/screens/pages/home/planner/planner_screen.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_screen.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_screen.dart';
import 'package:pantry_plus/screens/pages/start_screen/start_screen.dart';
import 'package:http/http.dart' as http;

import '../../data/model/item_model.dart';
import 'planner/meal_planner_controller.dart';

class HomeController extends GetxController {
  var selectedPage = (0).obs; //selected screen number
  var isLoading = false.obs;
  final List<Widget> pages = [
    const KitchenScreen(),
    const RecipeScreen(),
    const PlannerScreen(),
    const DiningScreen(),
    const ProfileScreen(),
  ];
  final AuthApi auth = AuthApi();
  late Rx<DateTime> mealPlanDate;
  var onMealPlan = false.obs;
  var recipeList = <Recipe>[].obs;
  var ingredients = <ItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    readRecipeFile();
    readIngredientsFile();
    mealPlanDate = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0, 0, 0)
        .obs;
  }

  Future<List<dynamic>> readJson(String path, String type) async {
    // final String response = await rootBundle.loadString(path);
    try {
      final response = await http.get(Uri.parse(path)).then((value) {
        return value.body;
      });

      final data = await json.decode(response);

      return data[type];
    } catch (e) {
      //snackbar to show error
      log(e.toString());
      Get.snackbar("Something went wrong", "Error while fetching data");
      return Future.value([]);
    }
  }

  void readRecipeFile() async {
    isLoading(true);
    update();
    var dummy = await readJson(
        "https://deproject1.vercel.app/api/recipes/v1", 'recipes');
    if (dummy.isEmpty) {
      return;
    }
    dummy = dummy.map((e) {
      final Map<String, dynamic> data = {
        'id': e['id'],
        'title': e['title'],
        'ingredients': e['ingredients'],
        'directions': e['directions'],
        'meals': e['meals'],
        'imgUrl': e['imgUrl'],
        'language': e['language'],
        'foodType': e['foodType'],
        'duration': e['duration'],
        'complexity': e['complexity'],
        'affordability': e['affordability']
      };
      return data;
    }).toList();

    recipeList(dummy.map((e) {
      return Recipe.fromJson(e);
    }).toList());
    update();

    isLoading(false);
    update();
  }

  void readIngredientsFile() async {
    isLoading(true);
    update();
    var dummy =
        await readJson("https://deproject1.vercel.app/api/items/v1", 'items');
    if (dummy.isEmpty) {
      return;
    }
    dummy = dummy.map((e) {
      final Map<String, dynamic> data = {
        'itemId': e['_id'],
        'itemName': e['itemName'],
        'description': e['description'],
        'itemKeywords': e['itemKeywords'],
        'itemImage': e['itemImage'],
        'itemCategory': e['itemCategory'],
        'quantityType': e['quantityType'],
        'expiryDate': expiryDateToMilli(e['expiryDate']),
      };
      return data;
    }).toList();

    ingredients(dummy.map((e) {
      return ItemModel.fromJson(e);
    }).toList());
    update();

    isLoading(false);
    update();
  }

  //function for changing screen
  void changeScreen(int value) {
    selectedPage(value);
    update();

    switch (value) {
      case 0:
        Get.delete<ProfileController>();
        Get.delete<RecipeController>();
        Get.delete<MealPlannerController>();
        update();
        log("Kitchen Screen");
        return;
      case 1:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        Get.delete<MealPlannerController>();
        onMealPlan(false);
        update();
        log("Recipe Screen");
        return;
      case 2:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        Get.delete<RecipeController>();
        onMealPlan(true);
        update();
        log("Planner Screen");
        return;
      case 3:
        Get.delete<KitchenController>();
        Get.delete<ProfileController>();
        Get.delete<RecipeController>();
        Get.delete<MealPlannerController>();
        update();
        log("Dining Screen");
        return;
      case 4:
        Get.delete<KitchenController>();
        Get.delete<RecipeController>();
        Get.delete<MealPlannerController>();
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

  String expiryDateToMilli(String data) {
    final raw = data.split(" ");
    var month = 0;
    var year = 0;
    var day = 0;
    if (raw.last.toLowerCase() == "month" ||
        raw.last.toLowerCase() == "months") {
      month = int.tryParse(raw.first)! * 30;
    } else if (raw.last.toLowerCase() == "year" ||
        raw.last.toLowerCase() == "years") {
      year = int.tryParse(raw.first)! * 365;
    } else if (raw.last.toLowerCase() == "week" ||
        raw.last.toLowerCase() == "weeks") {
      day = int.tryParse(raw.first)! * 7;
    } else {
      day = int.tryParse(raw.first)!;
    }

    DateTime now = DateTime.now();

    // Calculate the future date by adding the specified number of months
    DateTime futureDate = DateTime(
        now.year + year,
        now.month + month,
        now.day + day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond);

    // Calculate the difference between the future date and the current date
    Duration difference = futureDate.difference(now);

    // Convert the difference into milliseconds
    int milliseconds = difference.inMilliseconds;
    return milliseconds.toString();
  }
}
