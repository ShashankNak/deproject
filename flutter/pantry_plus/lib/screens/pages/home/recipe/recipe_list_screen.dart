import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/recipe/components/recipe_card.dart';

import '../../../../data/model/recipe_model.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen(
      {super.key, required this.category, required this.filteredList});
  final String category;
  final List<Recipe> filteredList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.capitalize!),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      backgroundColor: Get.theme.colorScheme.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${filteredList.length} Recipes Found"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return RecipeCard(filteredList: filteredList, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
