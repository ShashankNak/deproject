import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  const CategoryMealScreen(
      {required this.availableMeals, super.key, required this.categorytitle});
  final String categorytitle;
  final List<Meal> availableMeals;

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  //This is for MaterialPageRoutes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.primary,
        title: Text(widget.categorytitle),
      ),
      body: widget.availableMeals.isEmpty
          ? const Center(
              child: Text("You don't have any recipe yet!.."),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  meal: widget.availableMeals[index],
                );
              },
              itemCount: widget.availableMeals.length,
            ),
    );
  }
}
