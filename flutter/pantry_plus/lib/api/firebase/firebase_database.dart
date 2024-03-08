import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
}
