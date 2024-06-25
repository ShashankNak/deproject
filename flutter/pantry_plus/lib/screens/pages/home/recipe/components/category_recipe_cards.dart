import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/recipe/recipe_controller.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';

import '../receipe_details_screen.dart';

class CategoryRecipeCards extends StatelessWidget {
  const CategoryRecipeCards({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeController>();
    List<Recipe> filteredList = controller.recipeList
        .where((element) => element.foodType.contains(category))
        .toList();
    if (filteredList.length > 10) {
      filteredList = filteredList.sublist(0, 10);
    }
    return GetBuilder(
      init: controller,
      builder: (context) {
        if (filteredList.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(bottom: Get.size.height / 40),
            child: Center(
              child: Text(
                "No Recipes Yet.......",
                softWrap: true,
                overflow: TextOverflow.fade,
                style: Get.textTheme.headlineMedium,
              ),
            ),
          );
        } else {
          return SizedBox(
            height: Get.size.height / 3,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: Get.size.shortestSide / 90,
                right: Get.size.shortestSide / 90,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final recipe = filteredList[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => RecipeDetailsScreen(
                        recipe: recipe,
                        index: index,
                      ),
                      transition: Transition.fade,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: recipe.imgUrl,
                            height: Get.size.height / 4,
                            alignment: Alignment.center,
                            width: Get.size.width / 1.2,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                              width: Get.size.shortestSide / 20,
                              height: Get.size.shortestSide / 20,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/dum_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Get.size.longestSide / 13,
                          right: Get.size.shortestSide / 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black54,
                            ),
                            width: Get.size.shortestSide / 1.5,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: Text(
                              recipe.title,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Get.size.shortestSide / 20,
                                color: Colors.white,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
