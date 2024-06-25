import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../controller/home/recipe/recipe_controller.dart';
import '../receipe_details_screen.dart';

class RecipeSlider extends StatelessWidget {
  const RecipeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeController>();
    return GetBuilder(
      init: controller,
      builder: (context) {
        return SizedBox(
          height: Get.size.longestSide / 2.5,
          child: Column(
            children: [
              SizedBox(
                height: Get.size.shortestSide / 20,
              ),
              CarouselSlider(
                items: controller.top5RecipesList.asMap().entries.map((entry) {
                  int index = entry.key;
                  var recipe = entry.value;
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => RecipeDetailsScreen(recipe: recipe, index: index),
                        transition: Transition.fade,
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: recipe.imgUrl,
                            height: Get.size.height / 3,
                            alignment: Alignment.center,
                            width: Get.size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                                width: Get.size.shortestSide / 20,
                                height: Get.size.shortestSide / 20,
                                child: const Center(
                                    child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/dum_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Get.size.longestSide / 60,
                          right: Get.size.shortestSide / 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black54,
                            ),
                            width: Get.size.shortestSide / 1.5,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
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
                  );
                }).toList(),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    controller.currentIndex.value = index;
                    controller.update();
                  },
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  height: Get.size.longestSide / 3,
                ),
              ),
              SizedBox(
                height: Get.size.shortestSide / 90,
              ),
              AnimatedSmoothIndicator(
                activeIndex: controller.currentIndex.value,
                count: controller.top5RecipesList.length,
                effect: WormEffect(
                  dotWidth: Get.size.shortestSide / 40,
                  dotHeight: Get.size.shortestSide / 40,
                  dotColor: Get.theme.colorScheme.primary,
                  spacing: Get.size.shortestSide / 40,
                  activeDotColor: Get.theme.colorScheme.onSecondary,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
              SizedBox(
                height: Get.size.shortestSide / 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
