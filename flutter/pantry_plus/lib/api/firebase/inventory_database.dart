import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pantry_plus/data/model/user_selected_ingredients_model.dart';

class InventoryDatabase {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<bool> storeMultipleInventory(
      List<UserSelectedIngredientsModel> inventory) async {
    try {
      for (UserSelectedIngredientsModel item in inventory) {
        await firestore
            .collection("usersInventory")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("inventory")
            .doc(item.itemModel.itemId)
            .set(item.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> storeInventory(
      UserSelectedIngredientsModel inventory) async {
    try {
      await firestore
          .collection("usersInventory")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("inventory")
          .doc(inventory.itemModel.itemId)
          .set(inventory.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getUserInventoryAsStream() {
    return firestore
        .collection("userInventory")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("inventory")
        .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>>
      getUserInventoryAsFuture() async {
    return firestore
        .collection("userInventory")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("inventory")
        .get();
  }

  static Future<bool> deleteInventory(
      UserSelectedIngredientsModel model) async {
    try {
      await firestore
          .collection("usersInventory")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("inventory")
          .doc(model.itemModel.itemId)
          .delete();

      if (model.itemModel.itemImage
          .contains('firebasestorage.googleapis.com')) {
        await storage
            .ref()
            .child(
                'userIngredients/${firebaseAuth.currentUser!.uid}/${model.itemModel.itemId}.jpg')
            .delete();

        await storage
            .ref()
            .child(
                'userIngredients/${firebaseAuth.currentUser!.uid}/${model.itemModel.itemId}.png')
            .delete();
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
