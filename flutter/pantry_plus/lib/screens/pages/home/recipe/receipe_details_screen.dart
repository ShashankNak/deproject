import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/recipe/recipe_controller.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';
import 'package:pantry_plus/screens/pages/home/recipe/components/meal_plan_option.dart';

import '../../../../api/firebase/firebase_database.dart';
import '../../../../data/model/meal_model.dart';
import '../widgets/fade_in_down.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen(
      {super.key, required this.recipe, required this.index});
  final Recipe recipe;
  final int index;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeController>();

    return Scaffold(
        appBar: AppBar(
            title: const Text("Recipe Details"),
            centerTitle: true,
            backgroundColor: Get.theme.colorScheme.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                controller.selectedMealPlan.value = "";
                controller.update();
                Get.back();
              },
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.size.height / 3,
                width: Get.size.width,
                child: Hero(
                  tag: '${widget.recipe.title}-${widget.index}',
                  child: CachedNetworkImage(
                    imageUrl: widget.recipe.imgUrl,
                    alignment: Alignment.center,
                    width: Get.size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                        width: Get.size.shortestSide / 20,
                        height: Get.size.shortestSide / 20,
                        child:
                            const Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/dum_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.size.width / 20),
                  child: Text(widget.recipe.title,
                      style: Get.textTheme.headlineSmall),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Container(
                  color: Get.theme.colorScheme.primary,
                  height: Get.size.longestSide / 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.schedule),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(widget.recipe.duration),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.work),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(widget.recipe.complexity
                              .toString()
                              .split(".")
                              .last),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.attach_money),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(widget.recipe.affordability
                              .toString()
                              .split(".")
                              .last),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.size.width / 20),
                  child: Text("FoodType", style: Get.textTheme.headlineSmall),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: SizedBox(
                  width: Get.size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.colorScheme.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.recipe.foodType.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text("${index + 1}"),
                            ),
                            title: Text(widget.recipe.foodType[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.size.width / 20),
                  child:
                      Text("Ingredients", style: Get.textTheme.headlineSmall),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: Get.size.height / 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.recipe.ingredients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text(widget.recipe.ingredients[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.size.width / 20),
                  child: Text("Steps", style: Get.textTheme.headlineSmall),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: Get.size.height / 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.recipe.directions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text(widget.recipe.directions[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                from: 50,
                child: Container(
                  width: Get.size.shortestSide,
                  padding: EdgeInsets.only(left: Get.size.width / 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Meal", style: Get.textTheme.headlineSmall),
                      // a datePicker
                      GestureDetector(
                        onTap: () => controller.selectDate(
                            Get.context!, widget.recipe.id),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Get.size.shortestSide / 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: Get.size.shortestSide / 20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.white),
                                const SizedBox(width: 8.0),
                                Obx(
                                  () => Text(
                                    "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year} ",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.longestSide / 80,
              ),
              if (controller.isLoading.value)
                const Center(child: CircularProgressIndicator())
              else
                GetBuilder(
                    init: controller,
                    builder: (context) {
                      return StreamBuilder(
                          stream: FirebaseDatabase.getMeals(controller
                              .selectedDate.value.millisecondsSinceEpoch
                              .toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            // Update mealList outside the build method
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: Text("No Meals Found"),
                              );
                            }

                            final meals = snapshot.data!.docs
                                .map(
                                    (e) => MealPlanningModel.fromJson(e.data()))
                                .toList();

                            controller.mealList.assignAll(meals);
                            // updating the controller.selectedMealPlan from database for the particular recipe
                            final mealPlan = controller.mealList
                                .where((p0) =>
                                    p0.recipeId.contains(widget.recipe.id))
                                .toList();
                            controller.selectedMealPlan.value =
                                mealPlan.isEmpty ? "" : mealPlan.first.id;

                            return FadeInDown(
                              delay: const Duration(milliseconds: 800),
                              duration: const Duration(milliseconds: 500),
                              from: 50,
                              child: MealPlanOption(
                                recipe: widget.recipe,
                              ),
                            );
                          });
                    }),
              SizedBox(
                height: Get.size.longestSide / 20,
              ),
            ],
          ),
        ));
  }
}
