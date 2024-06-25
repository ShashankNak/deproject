// ignore_for_file: constant_identifier_names

enum Quantity { gm, ml, kg, l, dozen }

enum Category {
  fruits_vegetables,
  dairy,
  meat,
  bakery,
  beverages,
  snacks,
  grain_pulses,
  spices,
  dryFruits,
  other
}

class ItemModel {
  late String itemId;
  late String itemName;
  late String description;
  late List<String> itemKeywords;
  late String itemImage;
  late Category itemCategory;
  late Quantity quantityType;
  late String expiryDate;

  ItemModel(
      {required this.itemId,
      required this.itemName,
      required this.description,
      required this.itemKeywords,
      required this.itemImage,
      required this.itemCategory,
      required this.quantityType,
      required this.expiryDate});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'] ?? "";
    itemName = json['itemName'] ?? "";
    description = json['description'] ?? "";
    itemKeywords = json['itemKeywords'].split(",") ?? [];
    itemImage = json['itemImage'] ?? "";
    itemCategory = _categoryFromJson(json);
    quantityType = _quantityTypeFromJson(json);
    expiryDate = json['expiryDate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'description': description,
      'itemKeywords': itemKeywords.join(" "),
      'itemImage': itemImage,
      'itemCategory': itemCategory.toString().split(".").last,
      'quantityType': quantityType.toString().split(".").last,
      'expiryDate': expiryDate,
    };
  }

  Category _categoryFromJson(Map<String, dynamic> json) {
    return json['itemCategory'] == "fruits_vegetables"
        ? Category.fruits_vegetables
        : json['itemCategory'] == "dairy"
            ? Category.dairy
            : json['itemCategory'] == "meat"
                ? Category.meat
                : json['itemCategory'] == "bakery"
                    ? Category.bakery
                    : json['itemCategory'] == "beverages"
                        ? Category.beverages
                        : json['itemCategory'] == "snacks"
                            ? Category.snacks
                            : json['itemCategory'] == "spices"
                                ? Category.spices
                                : json['itemCategory'] == "grain_pulses"
                                    ? Category.grain_pulses
                                    : json['itemCategory'] == "dryFruits"
                                        ? Category.dryFruits
                                        : Category.other;
  }

  Quantity _quantityTypeFromJson(Map<String, dynamic> json) {
    return json['quantityType'] == "gm"
        ? Quantity.gm
        : json['quantityType'] == "ml"
            ? Quantity.ml
            : json['quantityType'] == "kg"
                ? Quantity.kg
                : json['quantityType'] == "l"
                    ? Quantity.l
                    : Quantity.dozen;
  }
}
