import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/planner/meal_planner_controller.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_list_screen.dart';

class MealGrid extends StatefulWidget {
  final String title;
  final int index;

  const MealGrid({super.key, required this.title, required this.index});

  @override
  MealGridState createState() => MealGridState();
}

class MealGridState extends State<MealGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MealPlannerController>();

    return GestureDetector(
      onTap: () {
        if (controller.mealList[widget.index].recipeId.isNotEmpty) {
          Get.to(
              () => RecipeListScreen(
                  category: widget.title,
                  filteredList: controller.recipeList
                      .where((element) => controller
                          .mealList[widget.index].recipeId
                          .contains(element.id))
                      .toList()),
              transition: Transition.fade);
        }
      },
      child: SizedBox(
        height: Get.size.longestSide / 3.5,
        width: Get.size.shortestSide / 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: GetBuilder<MealPlannerController>(
                  init: controller,
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: Get.size.shortestSide / 60),
                        IconButton(
                            onPressed: () =>
                                controller.deleteMeal(widget.index),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: Center(
                  child: GestureDetector(
                    onTap: () => controller.selectTime(widget.index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Obx(() => Text(
                                controller.selectedTime[widget.index]
                                    .format(Get.context!),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[300],
                height: Get.size.longestSide / 6.8,
                child: Stack(
                  children: [
                    if (controller.mealList[widget.index].recipeId.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'No recipes added',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ListView.builder(
                      itemCount:
                          controller.mealList[widget.index].recipeId.length,
                      itemBuilder: (context, index) {
                        final recipes = controller.recipeList
                            .where((element) => controller
                                .mealList[widget.index].recipeId
                                .contains(element.id))
                            .toList();

                        log(recipes.length.toString());

                        return recipes.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.size.shortestSide / 40,
                                    vertical: Get.size.shortestSide / 80),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Get.theme.colorScheme.primary,
                                    // Set the background color
                                    borderRadius: BorderRadius.circular(
                                        Get.size.shortestSide /
                                            10), // Set the border radius
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.size.shortestSide / 40,
                                  ), // Add padding
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Distribute space evenly
                                    children: [
                                      Expanded(
                                        child: Text(
                                          recipes[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                        onPressed: () =>
                                            controller.deleteRecipeFromMeal(
                                                recipes[index].id,
                                                widget.index),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () {
                            if (controller
                                .mealList[widget.index].time.isEmpty) {
                              Get.snackbar(
                                  'Error', 'Please select a time for the meal');
                              return;
                            }
                            controller.hCont.selectedPage(1);
                            controller.hCont.update();
                          },
                          icon: const Icon(Icons.add)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
