import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/data/model/user_selected_ingredients_model.dart';

import '../../../../../utils/const.dart';

class UserInventCard extends StatelessWidget {
  final UserSelectedIngredientsModel inventModel;

  const UserInventCard({super.key, required this.inventModel});

  @override
  Widget build(BuildContext context) {
    final KitchenController controller = Get.find<KitchenController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return InkWell(
            splashColor: Get.theme.colorScheme.secondary,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: int.tryParse(inventModel.expiryDate)! -
                              DateTime.now().millisecondsSinceEpoch <=
                          0
                      ? Colors.redAccent
                      : Get.theme.colorScheme.onPrimary,
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
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.size.shortestSide / 20,
                              right: Get.size.shortestSide / 20,
                              top: Get.size.longestSide / 50),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: SizedBox(
                                height: Get.size.longestSide / 10,
                                width: Get.size.width,
                                child: Hero(
                                  tag:
                                      "image_${inventModel.itemModel.itemId}_${DateTime.now().millisecondsSinceEpoch}",
                                  child: CachedNetworkImage(
                                    imageUrl: inventModel.itemModel.itemImage,
                                    alignment: Alignment.center,
                                    height: Get.size.longestSide / 10,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SizedBox(
                                        width: Get.size.shortestSide / 20,
                                        height: Get.size.shortestSide / 20,
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/dum_image.jpg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Get.size.height / 80,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.size.width / 50),
                          child: Text(
                            inventModel.itemModel.itemName,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: Get.size.shortestSide / 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.size.width / 50),
                          child: SizedBox(
                            height: Get.size.height / 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.size.width / 50,
                                ),
                                Text(
                                  "${inventModel.quantity} ${convertQuantityToString(inventModel.itemModel.quantityType)}",
                                  style: TextStyle(
                                      fontSize: Get.size.shortestSide / 25,
                                      fontWeight: FontWeight.w600),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      backgroundColor: int.tryParse(
                                                      inventModel.expiryDate)! -
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch <=
                                              0
                                          ? Colors.amber
                                          : Colors.transparent,
                                    ),
                                    onPressed: () => controller
                                        .deleteInventoryItem(inventModel),
                                    splashColor: Colors.black,
                                    icon: const Icon(Icons.delete_outline),
                                    color: int.tryParse(
                                                    inventModel.expiryDate)! -
                                                DateTime.now()
                                                    .millisecondsSinceEpoch <=
                                            0
                                        ? Get.theme.colorScheme.onPrimary
                                        : Colors.redAccent,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.size.height / 80,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.size.shortestSide / 50,
                          vertical: Get.size.longestSide / 80),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: int.tryParse(inventModel.expiryDate)! -
                                        DateTime.now().millisecondsSinceEpoch <=
                                    0
                                ? Colors.grey
                                : Colors.amber,
                          ),
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: Get.size.width / 90),
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: Get.size.width / 35,
                                ),
                                SizedBox(width: Get.size.width / 90),
                                Text(
                                  controller.expiryDateFormatter(
                                      inventModel.expiryDate),
                                  style: TextStyle(
                                      fontSize: Get.size.width / 35,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: Get.size.width / 90),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
