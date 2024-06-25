import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';

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
                      ? const Text(
                          'No Data Found!',
                          style: TextStyle(fontSize: 20),
                        )
                      : ListView.builder(
                          itemCount: controller.titles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.titles[index]),
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
