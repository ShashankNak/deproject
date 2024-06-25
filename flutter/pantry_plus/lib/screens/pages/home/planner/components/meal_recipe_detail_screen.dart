import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';

import '../../widgets/fade_in_down.dart';

class MealRecipeDetailsScreen extends StatefulWidget {
  const MealRecipeDetailsScreen(
      {super.key, required this.recipe, required this.index});
  final Recipe recipe;
  final int index;

  @override
  State<MealRecipeDetailsScreen> createState() =>
      _MealRecipeDetailsScreenState();
}

class _MealRecipeDetailsScreenState extends State<MealRecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe Details"),
          centerTitle: true,
          backgroundColor: Get.theme.colorScheme.primary,
        ),
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
                height: Get.size.longestSide / 20,
              ),
            ],
          ),
        ));
  }
}
