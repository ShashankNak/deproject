import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/new_item.dart/new_item_controller.dart';
import 'package:pantry_plus/data/model/item_model.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewItemController controller = Get.put(NewItemController());
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Scaffold(
              body: Column(
            children: [
              AppBar(
                backgroundColor: Get.theme.colorScheme.primary,
                title: const Text("Add an Item"),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.focusScope!.unfocus(),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formkey,
                      child: Padding(
                        padding: EdgeInsets.all(Get.size.shortestSide / 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            //textfield for adding item name by user
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a valid Item Name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                controller.newItem.update((val) {
                                  val!.itemName = value ?? "";
                                });
                                controller.update();
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Item Name",
                                hintText: "Enter Item Name",
                              ),
                            ),

                            const SizedBox(height: 20),
                            // An image picker to add image of the item wrap under a background image
                            Container(
                              width: Get.size.width / 2,
                              height: Get.size.width / 2,
                              padding:
                                  EdgeInsets.all(Get.size.shortestSide / 90),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                              child: GestureDetector(
                                onTap: controller.getNewItemImage,
                                child: Stack(
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.add_a_photo,
                                      ),
                                    ),
                                    if (controller.newItem.value.itemImage !=
                                        "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(controller
                                              .newItem.value.itemImage),
                                          fit: BoxFit.cover,
                                          width: Get.size.shortestSide / 2,
                                          height: Get.size.shortestSide / 2,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //dropdown for selecting category of the item
                                DropdownMenu<Category>(
                                  width: Get.size.width / 2.5,
                                  textStyle: Get.theme.textTheme.bodyLarge!
                                      .copyWith(
                                          fontSize: Get.size.shortestSide / 20),
                                  requestFocusOnTap: false,
                                  label: const Text('Category'),
                                  inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Get.size.width / 10)),
                                    ),
                                  ),
                                  onSelected: (Category? category) {
                                    log(category.toString());
                                    controller.newItem.update((val) {
                                      val!.itemCategory = category!;
                                    });
                                  },
                                  initialSelection: Category.dairy,
                                  menuHeight: Get.size.height / 3,
                                  dropdownMenuEntries: List.generate(
                                      Category.values.length,
                                      (index) => DropdownMenuEntry<Category>(
                                          value: Category.values[index],
                                          label: Category.values[index]
                                              .toString()
                                              .split(".")
                                              .last
                                              .capitalizeFirst!)),
                                ),

                                //textfield for adding quantity of the item by user
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
                                            if (value!.isEmpty) {
                                              return "Please enter a valid Quantity";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            controller.newItem.update((val) {
                                              val!.quantity = value ?? "";
                                            });
                                            controller.update();
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
                                          textStyle: Get
                                              .theme.textTheme.bodyLarge!
                                              .copyWith(
                                                  fontSize:
                                                      Get.size.shortestSide /
                                                          30),
                                          requestFocusOnTap: false,
                                          inputDecorationTheme:
                                              InputDecorationTheme(
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
                                            controller.newItem.update((val) {
                                              val!.quantityType =
                                                  type ?? Quantity.gm;
                                            });
                                          },
                                          initialSelection: Quantity.gm,
                                          trailingIcon: null,
                                          menuHeight: Get.size.height / 5,
                                          dropdownMenuEntries: List.generate(
                                              Quantity.values.length,
                                              (index) => DropdownMenuEntry<
                                                      Quantity>(
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
                              ],
                            ),

                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.dateController.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a valid Expiry Date";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                controller.newItem.update((val) {
                                  val!.expiryDate = value!;
                                });
                                log(controller.newItem.value.expiryDate);
                                controller.update();
                              },
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
                                    context: Get.context!);
                              },
                            ),
                            const SizedBox(height: 20),

                            //text
                            TextFormField(
                              onSaved: (newValue) {
                                controller.newItem.update((val) {
                                  val!.description = newValue ?? "";
                                });
                                controller.update();
                              },
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter Description",
                                  labelText: "Description",
                                  alignLabelWithHint: true),
                            ),

                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: controller.addNewItem,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Get.theme.colorScheme.primary,
                                  foregroundColor:
                                      Get.theme.colorScheme.background,
                                  fixedSize: Size(Get.size.width / 2,
                                      Get.size.height / 20)),
                              child: const Text("Add Item"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
        });
  }
}
