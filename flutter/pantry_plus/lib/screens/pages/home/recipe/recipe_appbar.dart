import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeAppbar extends StatelessWidget {
  const RecipeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.colorScheme.primary,
      title: const Text('Recipes'),
      centerTitle: true,
    );
  }
}
