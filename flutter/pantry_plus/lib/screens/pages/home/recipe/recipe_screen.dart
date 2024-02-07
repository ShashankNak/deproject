import 'package:flutter/widgets.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_dummy/screen/categories_screen.dart';
import 'package:pantry_plus/screens/pages/home/recipe/recipe_appbar.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RecipeAppbar(),
        Expanded(
          child: CategoriesScreen(),
        ),
      ],
    );
  }
}
