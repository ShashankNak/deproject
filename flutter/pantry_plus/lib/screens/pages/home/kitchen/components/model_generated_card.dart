import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/components/item_details_screen.dart';

class ModelGeneratedScreen extends StatelessWidget {
  const ModelGeneratedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KitchenController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('ModelGeneratedScreen'),
            ),
            body: Stack(
              children: [
                Center(
                  child: (controller.titles.isEmpty)
                      ? (controller.isLoading.value)
                          ? const Text(
                              'No Data Found!',
                              style: TextStyle(fontSize: 20),
                            )
                          : const Text(
                              'Fetching Data.........Please Wait!',
                              style: TextStyle(fontSize: 20),
                            )
                      : ListView.builder(
                          itemCount: controller.generatedData.length,
                          itemBuilder: (context, index) {
                            final item = controller.generatedData[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ItemDetailsScreen(item: item));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.size.shortestSide / 10)),
                                elevation: 7,
                                margin: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Get.size.shortestSide / 10),
                                    ),
                                  ),
                                  height: Get.size.height / 3,
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              Get.size.shortestSide / 10),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: item.itemImage,
                                          height: Get.size.height / 3,
                                          alignment: Alignment.center,
                                          width: Get.size.width,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => SizedBox(
                                              width: Get.size.shortestSide / 20,
                                              height:
                                                  Get.size.shortestSide / 20,
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator())),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/images/dum_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.black54,
                                          ),
                                          width: 250,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          child: Text(
                                            item.itemName,
                                            style: const TextStyle(
                                              fontSize: 26,
                                              color: Colors.white,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                if (controller.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        });
  }
}
