import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_dummy/model/dummy_data.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_dummy/screen/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(this.id, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => CategoryMealScreen(
                  availableMeals: dummyMeals
                      .where((element) => element.categories.contains(id))
                      .toList(),
                  categorytitle: title,
                ),
            transition: Transition.fadeIn);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            //for angle and direction
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
