import 'package:pantry_plus/data/model/item_model.dart';

class UserSelectedIngredientsModel {
  late ItemModel itemModel;
  late String quantity;
  late String expiryDate;

  UserSelectedIngredientsModel({
    required this.itemModel,
    required this.quantity,
    required this.expiryDate,
  });

  //model to json
  Map<String, dynamic> toJson() {
    return {
      'itemModel': itemModel.toJson(),
      'quantity': quantity,
      'expiryDate': expiryDate,
    };
  }

  //json to model
  UserSelectedIngredientsModel.fromJson(Map<String, dynamic> json) {
    itemModel = ItemModel.fromJson(json['itemModel']);
    quantity = json['quantity'] ?? "";
    expiryDate = json['expiryDate'] ?? "";
  }
}
