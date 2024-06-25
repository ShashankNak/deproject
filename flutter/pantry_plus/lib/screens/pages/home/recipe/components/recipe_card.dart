import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';
import 'package:pantry_plus/screens/pages/home/planner/components/meal_recipe_detail_screen.dart';

import '../receipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {super.key, required this.filteredList, required this.index});
  final List<Recipe> filteredList;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return InkWell(
      onTap: () {
        Get.to(
          () => controller.onMealPlan.value
              ? MealRecipeDetailsScreen(
                  recipe: filteredList[index], index: index)
              : RecipeDetailsScreen(
                  recipe: filteredList[index],
                  index: index,
                ),
          transition: Transition.fade,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Hero(
                  tag: '${filteredList[index].title}-$index',
                  child: CachedNetworkImage(
                    imageUrl: filteredList[index].imgUrl,
                    height: Get.size.height / 4,
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
              Positioned(
                bottom: Get.size.longestSide / 40,
                right: Get.size.shortestSide / 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54,
                  ),
                  width: 250,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    filteredList[index].title,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.schedule),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(filteredList[index].duration),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.work),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(filteredList[index]
                        .complexity
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
                    Text(filteredList[index]
                        .affordability
                        .toString()
                        .split(".")
                        .last),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
