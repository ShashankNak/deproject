import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/dining/dining_screen.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_screen.dart';
import 'package:pantry_plus/screens/pages/home/planner/planner_screen.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_screen.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_screen.dart';

class HomeController extends GetxController {
  var selectedPage = (0).obs; //selected screen number
  final List<Widget> pages = ([
    const KitchenScreen(),
    const RecipeScreen(),
    const PlannerScreen(),
    const DiningScreen(),
    const ProfileScreen(),
  ]);

  //function for changing screen
  void changeScreen(int value) {
    selectedPage(value);
    update();
    log(value.toString());
  }
}
