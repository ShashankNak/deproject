import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_list_screen.dart';

import '../../../../../data/model/recipe_model.dart';

class RecipeCategoryLabel extends StatelessWidget {
  const RecipeCategoryLabel(
      {super.key, required this.title, required this.filteredList});
  final String title;
  final List<Recipe> filteredList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.primary,
      // padding: EdgeInsets.symmetric(horizontal: Get.size.shortestSide / 20),
      width: Get.size.shortestSide,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.size.shortestSide / 20,
            vertical: Get.size.shortestSide / 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                title
                    .split("-")
                    .map((e) => e.capitalizeFirst)
                    .toList()
                    .join("-"),
                style: Get.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () => Get.to(
                    () => RecipeListScreen(
                        category: title, filteredList: filteredList),
                    transition: Transition.rightToLeftWithFade),
                icon: Icon(
                  CupertinoIcons.forward,
                  size: Get.size.shortestSide / 20,
                ))
          ],
        ),
      ),
    );
  }
}
