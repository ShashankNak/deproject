import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/components/custom_efab.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_appbar.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KitchenController());

    return GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            children: <Widget>[
              const KitchenAppbar(),
              //rest of the body
              Expanded(
                child: Stack(
                  children: [
                    Center(
                      child: Obx(() {
                        if (controller.titles.isEmpty) {
                          return const Text("No data");
                        } else {
                          return ListView.builder(
                            itemCount: controller.titles.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.titles[index]),
                              );
                            },
                          );
                        }
                      }),
                    ),
                    const CustomEFAB(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
