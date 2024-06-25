import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/recipe/recipe_controller.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';

class MealPlanOption extends StatelessWidget {
  const MealPlanOption({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeController>();

    return GetBuilder(
        init: controller,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.mealList.isEmpty
                ? Center(
                    child: Text(
                    "No Meals Found\n First add the Meal at that date",
                    style: Get.textTheme.headlineSmall!.copyWith(
                      color: Get.theme.colorScheme.primary,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ))
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: Get.size.shortestSide / 30,
                    mainAxisSpacing: Get.size.longestSide / 80,
                    children: controller.mealList.map((option) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            maximumSize: Size(Get.size.shortestSide / 3,
                                Get.size.longestSide / 25),
                            minimumSize: Size(Get.size.shortestSide / 3,
                                Get.size.longestSide / 25),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                controller.selectedMealPlan.value == option.id
                                    ? Get.theme.colorScheme.primary
                                    : Colors.grey[300],
                            foregroundColor:
                                controller.selectedMealPlan.value == option.id
                                    ? Colors.white
                                    : Colors.black,
                            textStyle: Get.textTheme.headlineSmall!.copyWith(
                              fontSize: Get.size.shortestSide / 20,
                            )),
                        onPressed: () =>
                            controller.updateMealPlan(recipe, option),
                        child: Text(option.title),
                      );
                    }).toList(),
                  ),
          );
        });
  }
}
