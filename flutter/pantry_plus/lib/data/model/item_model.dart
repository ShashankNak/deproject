class ItemModel {
  late String itemId;
  late String itemName;
  late List<String> itemKeywords;
  late String itemImage;
  late List<String> itemCategory;
  late String quantity;
  late String expiryDate;

  ItemModel(
      {required this.itemId,
      required this.itemName,
      required this.itemKeywords,
      required this.itemImage,
      required this.itemCategory,
      required this.quantity,
      required this.expiryDate});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemKeywords = json['itemKeywords'].split(" ");
    itemImage = json['itemImage'];
    itemCategory = json['itemCategory'].split(" ");
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemKeywords': itemKeywords.join(" "),
      'itemImage': itemImage,
      'itemCategory': itemCategory.join(" "),
      'quantity': quantity,
      'expiryDate': expiryDate,
    };
  }
}
