import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/recipe/recipe_controller.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller.searchController.value,
                    onChanged: controller.searchItem,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      hintText: "Search Recipe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(
                        fontSize: Get.size.shortestSide / 25,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: Get.size.shortestSide / 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                if (controller.searchText.value.isNotEmpty)
                  IconButton(
                      onPressed: () {
                        controller.searchController.value.clear();
                        controller.searchText.value = '';
                        controller.isSearching.value = false;
                        controller.filteredList.clear();
                        Get.focusScope!.unfocus();
                        controller.update();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: Get.size.shortestSide / 15,
                      )),
              ],
            ),
          );
        });
  }
}
