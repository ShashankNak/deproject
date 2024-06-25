import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/search_item_controller.dart/item_controller.dart';
import 'package:pantry_plus/data/model/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel itemModel;

  const ItemCard({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.find<ItemController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return InkWell(
            splashColor: Get.theme.colorScheme.secondary,
            onTap: () => controller.onTapSelection(itemModel),
            onLongPress: () => controller.onLongTapSelection(itemModel),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: controller.selectedItem.contains(itemModel.itemId)
                    ? Get.theme.colorScheme.secondary.withOpacity(0.5)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: const Offset(
                      3.0,
                      3.0,
                    ),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                          // color: Colors.grey[300],
                          height: Get.size.longestSide / 5,
                          width: Get.size.width,
                          child: Hero(
                            tag:
                                "image_${itemModel.itemId}_${DateTime.now().millisecondsSinceEpoch}",
                            child: CachedNetworkImage(
                              imageUrl: itemModel.itemImage,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SizedBox(
                                  width: Get.size.shortestSide / 10,
                                  height: Get.size.shortestSide / 10,
                                  child: const Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/dum_image.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      itemModel.itemName,
                      style: TextStyle(
                          fontSize: Get.size.shortestSide / 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
