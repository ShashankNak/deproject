import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/search_item_controller.dart/add_item_controller.dart';
import 'package:pantry_plus/data/model/item_model.dart';

class CustomIngredientCard extends StatefulWidget {
  const CustomIngredientCard({super.key, required this.item});
  final ItemModel item;

  @override
  State<CustomIngredientCard> createState() => _CustomIngredientCardState();
}

class _CustomIngredientCardState extends State<CustomIngredientCard> {
  final controller = Get.put(AddItemController());

  @override
  void initState() {
    super.initState();
    controller.initialize(widget.item);
  }

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
            widget.item.itemName,
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
                          "image_${widget.item.itemId}_${DateTime.now().millisecondsSinceEpoch}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(Get.size.shortestSide / 10),
                          bottomRight:
                              Radius.circular(Get.size.shortestSide / 10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.itemImage,
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
                  child: Text(
                      widget.item.itemCategory.toString().split(".").last,
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(fontSize: Get.size.shortestSide / 20)),
                ),
                buildSectionTitle(context, 'Descriptions'),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(widget.item.description,
                      style: Get.theme.textTheme.bodyLarge!
                          .copyWith(fontSize: Get.size.shortestSide / 20)),
                ),
                buildSectionTitle(context, 'Quantity & Expiry Date'),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.size.shortestSide / 20),
                  child: Text("(Check the Expiry date as per your product)",
                      style: Get.theme.textTheme.bodyLarge!.copyWith(
                          fontSize: Get.size.shortestSide / 30,
                          color: Colors.red)),
                ),

                //textfield for adding quantity of the item by user
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: controller.formkey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.size.longestSide / 15,
                          width: Get.size.shortestSide / 2.5,
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.size.shortestSide / 5,
                                child: TextFormField(
                                  minLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty || !value.isNum) {
                                      return "Please enter a valid Quantity";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    log(value!);
                                    controller.quantity.value = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            Get.size.width / 10),
                                        bottomLeft: Radius.circular(
                                            Get.size.width / 10),
                                      ),
                                    ),
                                    labelText: "Quantity",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.size.width / 5,
                                height: Get.size.longestSide / 15,
                                child: DropdownMenu<Quantity>(
                                  width: Get.size.width / 5,
                                  textStyle: Get.theme.textTheme.bodyLarge!
                                      .copyWith(
                                          fontSize: Get.size.shortestSide / 30),
                                  requestFocusOnTap: false,
                                  inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Get.size.width / 10),
                                        bottomRight: Radius.circular(
                                            Get.size.width / 10),
                                      ),
                                    ),
                                  ),
                                  onSelected: (Quantity? type) {
                                    log(type.toString());
                                    controller.quantityType.value = type!;
                                  },
                                  initialSelection:
                                      controller.quantityType.value,
                                  trailingIcon: null,
                                  menuHeight: Get.size.height / 5,
                                  dropdownMenuEntries: List.generate(
                                      Quantity.values.length,
                                      (index) => DropdownMenuEntry<Quantity>(
                                          value: Quantity.values[index],
                                          label: Quantity.values[index]
                                              .toString()
                                              .split(".")
                                              .last)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.size.longestSide / 15,
                          width: Get.size.shortestSide / 2.5,
                          child: TextFormField(
                            controller: controller.dateController.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a valid Expiry Date";
                              }
                              return null;
                            },
                            onSaved: (value) {},
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
                                    .copyWith(
                                        fontSize: Get.size.shortestSide / 20),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.all(10)),
                            onTap: () {
                              controller.showDateTimePicker(
                                context: Get.context!,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.size.longestSide / 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.addIngredientToList(widget.item),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.primary,
                        foregroundColor: Get.theme.colorScheme.background,
                        fixedSize:
                            Size(Get.size.width / 2, Get.size.height / 20)),
                    child: const Text("Add Item"),
                  ),
                ),
                SizedBox(height: Get.size.longestSide / 10),
              ]),
        ),
      ),
    );
  }
}
