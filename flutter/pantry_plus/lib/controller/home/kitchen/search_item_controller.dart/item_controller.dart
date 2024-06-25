import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry_plus/api/firebase/inventory_database.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
import 'package:pantry_plus/screens/pages/home/widgets/custom_ingredients_card.dart';
import 'package:pantry_plus/utils/const.dart';

import '../../../../data/model/item_model.dart';
import 'package:http/http.dart' as http;

import '../../../../data/model/user_selected_ingredients_model.dart';
import '../../../../screens/pages/home/kitchen/search/multiple_seleced_screen.dart';
import '../kitchen_controller.dart';

class ItemController extends GetxController {
  RxList<ItemModel> ingredients = <ItemModel>[].obs;
  var isLoading = false.obs;
  RxBool isSelecting = false.obs;
  RxBool isFiltering = false.obs;

  RxList<ItemModel> filteredItem = <ItemModel>[].obs;
  RxList<String> selectedItem = <String>[].obs;
  RxList<Category> filtered = Category.values.obs;

  RxMap<String, dynamic> mulQuantity = <String, dynamic>{}.obs;
  RxMap<String, dynamic> mulDate = <String, dynamic>{}.obs;
  RxMap<String, dynamic> mulQT = <String, dynamic>{}.obs;

  RxMap<String, TextEditingController> mulControllers =
      <String, TextEditingController>{}.obs;
  RxMap<String, TextEditingController> mulControllersQT =
      <String, TextEditingController>{}.obs;
  RxMap<String, TextEditingController> mulControllersDate =
      <String, TextEditingController>{}.obs;

  final kitchenController = Get.find<KitchenController>();
  final hCont = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    readFile();
  }

  void initializeMultipleScreen() {
    for (String id in selectedItem) {
      final item = ingredients.firstWhere((element) => element.itemId == id);
      final date = DateTime.now().millisecondsSinceEpoch +
          int.tryParse(item.expiryDate)!;
      mulDate.addAll({id: date});
      mulQuantity.addAll({id: 0});
      mulQT.addAll({id: item.quantityType});
      mulControllers.addAll({id: TextEditingController()});
      mulControllersQT.addAll({id: TextEditingController()});
      mulControllersDate.addAll({
        id: TextEditingController(
            text: DateFormat('dd-MM-yyyy hh:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(date)))
      });
      update();
    }
  }

  Future<void> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    required int index,
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
    mulDate.update(
        selectedItem[index].toString(), (value) => date.millisecondsSinceEpoch);
    mulControllersDate.update(selectedItem[index].toString(),
        (textEditingController) {
      textEditingController.text =
          DateFormat('dd-MM-yyyy hh:mm a').format(date);
      return textEditingController;
    });
    update();
  }

  void saveMultipleItems() async {
    isLoading(true);
    update();

    List<UserSelectedIngredientsModel> items = [];
    log("length: ${selectedItem.length}");

    for (String id in selectedItem) {
      ItemModel item =
          ingredients.firstWhere((element) => element.itemId == id);
      final date = mulDate[id];
      final quantity = mulQuantity[id];
      final qt = mulQT[id];
      item.quantityType = qt;

      //check if quantity must be empty then show a snackbar and return
      if (quantity == 0) {
        Get.snackbar("Error",
            "Quantity must be greater than 0 for item: ${item.itemName}",
            colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return;
      }

      items.add(
        UserSelectedIngredientsModel(
          itemModel: item,
          quantity: quantity.toString(),
          expiryDate: date.toString(),
        ),
      );
    }

    log('item Length: ${items.length.toString()}');

    await InventoryDatabase.storeMultipleInventory(items);

    isLoading(false);
    update();
    Get.back();
    Get.back();
  }

  void incrementQuantity(String id) {
    mulQuantity[id] = int.tryParse(mulControllers[id]!.text);
    mulQuantity[id] = mulQuantity[id] + 1;
    mulControllers[id]!.text = mulQuantity[id].toString();
    update();
  }

  void decrementQuantity(String id) {
    mulQuantity[id] = int.tryParse(mulControllers[id]!.text);
    if (mulQuantity[id] > 0) {
      mulQuantity[id] = mulQuantity[id] - 1;
      mulControllers[id]!.text = mulQuantity[id].toString();
      update();
    }
  }

  void moveToMultipleScreen() {
    initializeMultipleScreen();
    Get.to(() => const MulitpleSelectedScreen(),
        transition: Transition.rightToLeft);
  }

  void openFilterDialog() async {
    await FilterListDialog.display<Category>(
      Get.context!,
      listData: Category.values,
      selectedListData: filtered,
      choiceChipLabel: (category) => convertCategoryToString(category!),
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (category, query) {
        return category.name.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        filtered(list);
        update();
        log(filtered.toString());
        filterItems();
        Get.back();
      },
    );
  }

  void searchItem(String value) {
    filtered(Category.values);
    update();
    if (value.trim().isEmpty) {
      filteredItem(ingredients);
      update();
      return;
    }

    filteredItem(ingredients.where((element) {
      return element.itemName
              .toLowerCase()
              .contains(value.trim().toLowerCase()) ||
          element.itemKeywords
              .toString()
              .toLowerCase()
              .contains(value.trim()) ||
          element.description.toLowerCase().contains(value.trim());
    }).toList());
    update();
  }

  void filterItems() {
    filteredItem(ingredients.where((element) {
      return filtered.contains(element.itemCategory);
    }).toList());
    update();
  }

  void selectItem(String itemId) {
    selectedItem.add(itemId);
    update();
  }

  void deselectItem(String itemId) {
    selectedItem.remove(itemId);
    update();
  }

  Future<List<dynamic>> readJson(String path) async {
    // final String response = await rootBundle.loadString(path);
    try {
      final response = await http.get(Uri.parse(path)).then((value) {
        return value.body;
      });

      final data = await json.decode(response);
      return data['items'];
    } catch (e) {
      return Future.value([]);
    }
  }

  void readFile() async {
    isLoading(true);
    update();
    ingredients = hCont.ingredients;
    ingredients.shuffle();

    //temporary some changes in the image of Bikaneri Bhujia
    for (ItemModel item in ingredients) {
      if (item.itemName == "Bikaneri Bhujia") {
        item.itemImage =
            "https://5.imimg.com/data5/KB/DP/UY/SELLER-23743223/bikaneri-bhujia-1000x1000.jpg";
      }
    }

    filteredItem(ingredients);
    update();

    isLoading(false);
    update();
  }

  void onTapSelection(ItemModel itemModel) {
    if (isSelecting.isTrue) {
      if (selectedItem.contains(itemModel.itemId)) {
        deselectItem(itemModel.itemId);
        update();
        if (selectedItem.isEmpty) {
          isSelecting(false);
          update();
        }
      } else {
        selectItem(itemModel.itemId);
        update();
      }
    } else {
      Get.to(() => CustomIngredientCard(item: itemModel),
          transition: Transition.fade);
    }
  }

  void onLongTapSelection(ItemModel itemModel) {
    if (isSelecting.isFalse) {
      isSelecting(true);
      update();
      selectItem(itemModel.itemId);
      update();
    }
  }
}
