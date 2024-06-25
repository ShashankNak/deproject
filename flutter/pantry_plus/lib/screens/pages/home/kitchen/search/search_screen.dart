import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/search_item_controller.dart/item_controller.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/search/components/filter.dart';
import 'components/item_card.dart';

class SearchIngredients extends StatefulWidget {
  const SearchIngredients({super.key});

  @override
  State<SearchIngredients> createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  final controller = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Get.theme.colorScheme.primary,
                title: const Text('Search Inventory Items'),
                actions: [
                  if (controller.isSelecting.value)
                    IconButton(
                      onPressed: () => controller.moveToMultipleScreen(),
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                    )
                ],
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: Get.size.longestSide / 40,
                          ),
                          const Filter(),
                          SizedBox(
                            height: Get.size.longestSide / 30,
                          ),
                          Text(controller.isSelecting.value
                              ? "Tap for Multiple Select"
                              : "Long Press for Multiple Select"),
                          SizedBox(
                            height: Get.size.longestSide / 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.size.shortestSide / 20),
                            child: StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              children: [
                                Center(
                                  child: Text(
                                    "Found ${controller.filteredItem.length} results",
                                    style: TextStyle(
                                        fontSize: Get.size.shortestSide / 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (var i = 0;
                                    i < controller.filteredItem.length;
                                    i++)
                                  ItemCard(
                                    itemModel: controller.filteredItem[i],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.size.longestSide / 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isLoading.value)
                    Container(
                      color: Colors.white60,
                      width: Get.size.shortestSide,
                      height: Get.size.longestSide,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
