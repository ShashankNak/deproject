import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantryController extends GetxController {
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
