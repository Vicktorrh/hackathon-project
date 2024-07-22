import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathanproject/apis/users.dart';
import 'package:hackathanproject/core/snackbar.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future signInWithEmailProvider(BuildContext context) async {
    try {
      var cred = await firebaseAuth.signInWithProvider(GoogleAuthProvider());
      AppSnackBar.success(context, 'Login Successfully');

      return cred.user;
    } on FirebaseAuthException catch (e) {
      AppSnackBar.success(context, e.message ?? 'Error Logging in');
      print(e.message);
    }
  }

  Future SignUpWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserService.saveUserData(email: email);
      AppSnackBar.success(context, 'Registration Successfully');
      return cred.user;
    } on FirebaseException catch (e) {
      AppSnackBar.error(context, e.message ?? "Registration has failed");
      return null;
    }
  }

  @override
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      AppSnackBar.success(context, 'logged in successfully');
    } on FirebaseException catch (e) {
      AppSnackBar.error(context, e.message ?? "Please try logging in again");
    }
  }

  @override
  Future forgotPassword(BuildContext context, String userEmail) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: userEmail);
      AppSnackBar.success(context, 'Email sent successfully');
    } on FirebaseAuthException catch (e) {
      print(e);
      AppSnackBar.error(
          context, e.message ?? 'Email not found in our database');
    }
  }
}
