import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/recipe/components/filter_search.dart';
import 'package:pantry_plus/screens/pages/home/recipe/components/recipe_card.dart';
import 'package:pantry_plus/screens/pages/home/recipe/components/recipe_slider.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_appbar.dart';
import '../../../../controller/home/recipe/recipe_controller.dart';
import '../../../../data/model/recipe_model.dart';
import 'components/category_recipe_cards.dart';
import 'components/recipe_category_label.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final controller = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (context) {
        return InkWell(
          onTap: () {
            Get.focusScope!.unfocus();
          },
          child: Column(
            children: [
              const RecipeAppbar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.size.shortestSide / 20),
                      const FilterSearch(),
                      if (controller.isSearching.value) ...[
                        SizedBox(height: Get.size.shortestSide / 20),
                        Text(
                          "Found: ${controller.filteredList.length} Recipes",
                          style: Get.textTheme.headlineLarge!.copyWith(),
                        ),
                        SizedBox(
                          height: Get.size.height,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredList.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                filteredList: controller.filteredList,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ] else ...[
                        const RecipeSlider(),
                        ...FoodType.values
                            .map((category) => _buildCategorySection(category)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(FoodType category) {
    List<Recipe> filteredList = controller.recipeList
        .where(
            (element) => element.foodType.contains(getRecipeCategory(category)))
        .toList();
    return Column(
      children: [
        RecipeCategoryLabel(
          title: getRecipeCategory(category),
          filteredList: filteredList,
        ),
        SizedBox(height: Get.size.shortestSide / 20),
        CategoryRecipeCards(category: getRecipeCategory(category)),
      ],
    );
  }
}
