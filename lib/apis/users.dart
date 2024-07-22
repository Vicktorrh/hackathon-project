import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathanproject/model/users_model.dart';

class UserService {
  static final firebaseFirestore = FirebaseFirestore.instance;

  static Future saveUserData({
    required String email,
  }) async {
    UserModel userModel = UserModel(email: email, profilePic: '');
    try {
      await firebaseFirestore
          .collection('users')
          .doc(email)
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
}
