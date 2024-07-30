import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathanproject/model/users_model.dart';

class UserService {
  static final firebaseFirestore = FirebaseFirestore.instance;

  static Future saveUserData({
    required String email,
    required String id,
  }) async {
    UserModel userModel =
        UserModel(email: email, profilePic: '', seller: false, totalPrice: 0);
    try {
      await firebaseFirestore
          .collection('users')
          .doc(id)
          .set(userModel.toMap());
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  static Future<List<UserModel?>?> getAllUserData() async {
    try {
      var docs = await firebaseFirestore.collection('users').get();

      var listOfDocs = docs.docs;
      return listOfDocs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return null;
    }
  }

  static Future<UserModel?> getUserData() async {
    try {
      var docs = await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      var doc = docs.data();
      print(doc);
      print(FirebaseAuth.instance.currentUser?.uid);
      if (doc != null) {
        return UserModel.fromMap(doc);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return null;
    }
  }
}
