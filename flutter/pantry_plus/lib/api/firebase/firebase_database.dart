import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pantry_plus/data/model/meal_model.dart';
import 'package:pantry_plus/data/model/user_details_model.dart';

class FirebaseDatabase {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> storeUserDetails(UserDetailsModel user) async {
    log("Data stored");
    await firestore.collection("users").doc(user.fId).set(user.toJson());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
      String fId) {
    return firestore.collection("users").doc(fId).snapshots();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails2(
      String fId) async {
    return firestore.collection("users").doc(fId).get();
  }

  //save mealdetails
  static Future<void> storeMealDetails(MealPlanningModel meal) async {
    log("Data stored");
    await firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(meal.day)
        .doc(meal.id)
        .set(meal.toJson());
  }

  //get meals of particular day
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMeals(String day) {
    return firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(day)
        .snapshots();
  }

  //get Meals of particular day in future
  static Future<QuerySnapshot<Map<String, dynamic>>> getMealsFuture(
      String day) {
    return firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(day)
        .get();
  }

  //get a future meal of particular day and time
  static Future<DocumentSnapshot<Map<String, dynamic>>> getMealFuture(
      String day, String id) {
    return firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(day)
        .doc(id)
        .get();
  }

  //delete a meal
  static Future<void> deleteMeal(String day, String id) async {
    await firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(day)
        .doc(id)
        .delete();
  }

  //update meals
  static Future<void> updateMealDetails(
      MealPlanningModel meals, String day) async {
    log("Updating Meal");
    await firestore
        .collection("meal")
        .doc(firebaseAuth.currentUser!.uid)
        .collection(day)
        .doc(meals.id)
        .update(meals.toJson());
  }
}
