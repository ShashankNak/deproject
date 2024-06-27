import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/data/model/item_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final ItemModel item;

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: Get.size.shortestSide / 12),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.primary,
          title: Text(
            item.itemName,
            style: TextStyle(
              fontSize: Get.size.shortestSide / 15,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Get.size.shortestSide / 10),
                        bottomRight:
                            Radius.circular(Get.size.shortestSide / 10),
                      ),
                    ),
                    height: Get.size.longestSide / 2,
                    width: double.infinity,
                    child: Hero(
                      tag:
                          "image_${item.itemId}_${DateTime.now().millisecondsSinceEpoch}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(Get.size.shortestSide / 10),
                          bottomRight:
                              Radius.circular(Get.size.shortestSide / 10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item.itemImage,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.size.shortestSide / 8,
                                  vertical: Get.size.longestSide / 13),
                              child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/dum_image.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
                buildSectionTitle(context, 'Category'),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.itemCategory.toString().split(".").last,
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(fontSize: Get.size.shortestSide / 20)),
                ),
                buildSectionTitle(context, 'Descriptions'),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.description,
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(fontSize: Get.size.shortestSide / 20)),
                ),
                SizedBox(height: Get.size.longestSide / 10),
              ]),
        ),
      ),
    );
  }
}
