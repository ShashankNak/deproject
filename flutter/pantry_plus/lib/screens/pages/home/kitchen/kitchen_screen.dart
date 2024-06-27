import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/data/model/user_selected_ingredients_model.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/components/custom_efab.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_appbar.dart';

import 'components/user_inventory_card.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KitchenController());

    return Column(
      children: <Widget>[
        const KitchenAppbar(),
        //rest of the body
        if (controller.isLoading.value)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          Expanded(
            child: Stack(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("usersInventory")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("inventory")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }

                      final inventory = snapshot.data!.docs.map((e) {
                        return UserSelectedIngredientsModel.fromJson(e.data());
                      }).toList();

                      log(inventory.length.toString());

                      controller.inventory.assignAll(inventory);

                      return GetBuilder(
                          init: controller,
                          builder: (context) {
                            return Center(
                                child: inventory
                                        .where((p0) =>
                                            p0.itemModel.itemCategory ==
                                            controller.selectedCategory.value)
                                        .toList()
                                        .isEmpty
                                    ? Text(
                                        "Go and Drop Your \nInventory Items Here!",
                                        style: TextStyle(
                                            fontSize: Get.size.width / 20),
                                      )
                                    : GridView.builder(
                                        itemCount: inventory
                                            .where((p0) =>
                                                p0.itemModel.itemCategory ==
                                                controller
                                                    .selectedCategory.value)
                                            .toList()
                                            .length,
                                        itemBuilder: (context, index) {
                                          return UserInventCard(
                                            inventModel: inventory
                                                .where((p0) =>
                                                    p0.itemModel.itemCategory ==
                                                    controller
                                                        .selectedCategory.value)
                                                .toList()[index],
                                          );
                                        },
                                        padding: const EdgeInsets.all(25),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent:
                                              Get.size.shortestSide / 2,
                                          mainAxisExtent:
                                              Get.size.longestSide / 4.2,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing:
                                              Get.size.shortestSide / 20,
                                          mainAxisSpacing:
                                              Get.size.longestSide / 80,
                                        ),
                                      ));
                          });
                    }),
                const CustomEFAB(),
                if (controller.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
