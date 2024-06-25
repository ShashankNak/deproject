import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/search_item_controller.dart/item_controller.dart';

import '../../../../../data/model/item_model.dart';

class MulitpleSelectedScreen extends StatefulWidget {
  const MulitpleSelectedScreen({super.key});

  @override
  State<MulitpleSelectedScreen> createState() => _MulitpleSelectedScreenState();
}

class _MulitpleSelectedScreenState extends State<MulitpleSelectedScreen> {
  final controller = Get.find<ItemController>();

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
                title: const Text("Multiple Selected Screen"),
                actions: [
                  IconButton(
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () => controller.saveMultipleItems(),
                    icon: const Icon(Icons.save),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  ListView.builder(
                    itemCount: controller.selectedItem.length,
                    itemBuilder: (context, index) {
                      final items = controller.ingredients.firstWhere(
                          (element) =>
                              element.itemId == controller.selectedItem[index]);
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Get.size.shortestSide / 10)),
                        elevation: 7,
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(Get.size.shortestSide / 10),
                              topRight:
                                  Radius.circular(Get.size.shortestSide / 10),
                            ),
                          ),
                          height: Get.size.height / 2.9,
                          child: Column(children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        Get.size.shortestSide / 10),
                                    topRight: Radius.circular(
                                        Get.size.shortestSide / 10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: items.itemImage,
                                    height: Get.size.height / 4,
                                    alignment: Alignment.center,
                                    width: Get.size.width,
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54,
                                    ),
                                    width: 250,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Text(
                                      items.itemName,
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
                            SizedBox(
                              height: Get.size.longestSide / 80,
                            ),
                            SizedBox(
                              width: Get.size.shortestSide / 1.1,
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    quantityCounter(index),
                                    quantityTypeSelector(index),
                                    dateSelector(index),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                  if (controller.isLoading.value)
                    Container(
                      color: Colors.white.withOpacity(0.5),
                      width: Get.size.shortestSide,
                      height: Get.size.longestSide,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }

  Widget quantityCounter(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.size.shortestSide / 15),
        color: Get.theme.colorScheme.primaryContainer,
      ),
      width: Get.size.width / 3.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: controller.isLoading.value
                ? () {}
                : () => controller.decrementQuantity(
                    controller.selectedItem[index].toString()),
            icon: const Icon(Icons.remove),
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
          ),
          Expanded(
            child: SizedBox(
              height: Get.size.longestSide / 15,
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                enabled: !controller.isLoading.value,
                onChanged: (event) {
                  if (controller
                      .mulControllers[
                          controller.selectedItem[index].toString()]!
                      .text
                      .isEmpty) {
                    controller
                        .mulControllers[
                            controller.selectedItem[index].toString()]!
                        .text = "0";
                  }
                  controller.mulQuantity[controller.selectedItem[index]
                      .toString()] = int.tryParse(controller
                          .mulControllers[
                              controller.selectedItem[index].toString()]!
                          .text) ??
                      0;
                  controller.update();
                  controller
                      .mulControllers[
                          controller.selectedItem[index].toString()]!
                      .text = controller.mulQuantity[
                          controller.selectedItem[index].toString()]
                      .toString();
                  controller.update();
                },
                controller: controller
                    .mulControllers[controller.selectedItem[index].toString()]!
                  ..text = controller
                      .mulQuantity[controller.selectedItem[index].toString()]
                      .toString(),
                keyboardType: TextInputType.number,
                selectionControls: DesktopTextSelectionControls(),
                cursorColor: Colors.white,
                maxLines: 1,
                enableIMEPersonalizedLearning: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.size.width / 20,
                  color: Colors.white,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: controller.isLoading.value
                ? () {}
                : () => controller.incrementQuantity(
                    controller.selectedItem[index].toString()),
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
          ),
        ],
      ),
    );
  }

  Widget quantityTypeSelector(int index) {
    return SizedBox(
      width: Get.size.shortestSide / 4.2,
      height: Get.size.longestSide / 15,
      child: DropdownMenu<Quantity>(
        width: Get.size.width / 4.2,
        textStyle: Get.theme.textTheme.bodyLarge!
            .copyWith(fontSize: Get.size.shortestSide / 30),
        requestFocusOnTap: false,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(Get.size.shortestSide / 15))),
        ),
        onSelected: (Quantity? type) {
          controller
              .mulControllersQT[controller.selectedItem[index].toString()]!
              .text = type.toString().split(".").last;
        },
        initialSelection:
            controller.mulQT[controller.selectedItem[index].toString()]!,
        trailingIcon: null,
        menuHeight: Get.size.height / 5,
        enabled: !controller.isLoading.value,
        dropdownMenuEntries: List.generate(
            Quantity.values.length,
            (index) => DropdownMenuEntry<Quantity>(
                value: Quantity.values[index],
                label: Quantity.values[index].toString().split(".").last)),
      ),
    );
  }

  Widget dateSelector(int index) {
    return Container(
      height: Get.size.longestSide / 15,
      width: Get.size.shortestSide / 4,
      padding: EdgeInsets.only(top: Get.size.shortestSide / 90),
      child: TextFormField(
        controller: controller
            .mulControllersDate[controller.selectedItem[index].toString()]!,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a valid Expiry Date";
          }
          return null;
        },
        enabled: !controller.isLoading.value,
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        readOnly: true,
        style: Get.theme.textTheme.bodyLarge!.copyWith(
            color: Get.theme.colorScheme.onBackground,
            fontSize: Get.size.shortestSide / 20),
        decoration: InputDecoration(
            suffixIcon: const Icon(Icons.date_range),
            hintText: "Enter Expiry Date",
            labelText: "Expiry Date: ",
            labelStyle: Get.theme.textTheme.bodyLarge!
                .copyWith(fontSize: Get.size.shortestSide / 20),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10)),
        onTap: controller.isLoading.value
            ? () {}
            : () {
                controller.showDateTimePicker(
                  context: Get.context!,
                  index: index,
                );
              },
      ),
    );
  }
}
