import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry_plus/api/firebase/inventory_database.dart';
import 'package:pantry_plus/data/model/item_model.dart';

import '../../../../data/model/user_selected_ingredients_model.dart';

class AddItemController extends GetxController {
  var dateController = TextEditingController().obs;
  var quantity = "".obs;
  var expiryDate = "".obs;
  Rx<Quantity> quantityType = Quantity.gm.obs;
  final formkey = GlobalKey<FormState>();

  void initialize(ItemModel itemModel) {
    expiryDate.value = "";
    log(itemModel.expiryDate);
    try {
      log("Asdf");
      final date = DateTime.now().millisecondsSinceEpoch +
          int.tryParse(itemModel.expiryDate)!;
      expiryDate(date.toString());
      dateController.update((val) => val!.text =
          DateFormat('dd-MM-yyyy hh:mm a')
              .format(DateTime.fromMillisecondsSinceEpoch(date)));
      quantityType.value = itemModel.quantityType;
      update();
    } catch (e) {
      log("Some Error");
      log(e.toString());
    }
    log(quantityType.toString());
  }

  Future<void> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    initialDate ??= DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    final date = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
    log(date.millisecondsSinceEpoch.toString());
    expiryDate(date.millisecondsSinceEpoch.toString());
    dateController.update(
        (val) => val!.text = DateFormat('dd-MM-yyyy hh:mm a').format(date));
    update();
  }

  void addIngredientToList(ItemModel selectedItem) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }

    Get.focusScope!.unfocus();
    formkey.currentState!.save();

    UserSelectedIngredientsModel userSelectedIngredientsModel =
        UserSelectedIngredientsModel(
      itemModel: selectedItem,
      expiryDate: expiryDate.value,
      quantity: quantity.value,
    );

    InventoryDatabase.storeInventory(userSelectedIngredientsModel);
    Get.back();
    Get.back();
  }
}
