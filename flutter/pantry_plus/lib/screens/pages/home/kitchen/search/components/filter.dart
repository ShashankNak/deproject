import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/search_item_controller.dart/item_controller.dart';

class Filter extends StatelessWidget {
  const Filter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: controller.searchItem,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: "Search Food",
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
          InkWell(
            onTap: () => controller.openFilterDialog(),
            child: Container(
              width: Get.size.shortestSide / 8,
              height: Get.size.shortestSide / 8,
              decoration: BoxDecoration(
                color: Colors.amber[400],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.filter_list,
                size: Get.size.shortestSide / 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
