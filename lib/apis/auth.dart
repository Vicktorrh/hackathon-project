import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/users.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';

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

  Future<User?> SignUpWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserService.saveUserData(email: email, id: cred.user?.uid ?? "");
      AppSnackBar.success(context, 'Registration Successfully');
      return cred.user;
    } on FirebaseException catch (e) {
      AppSnackBar.error(context, e.message ?? "Registration has failed");
      return null;
    }
  }

  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      var cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      AppSnackBar.success(context, 'logged in successfully');
      return cred.user;
    } on FirebaseException catch (e) {
      AppSnackBar.error(context, e.message ?? "Please try logging in again");
    }
  }

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

  Future logout(BuildContext context) async {
    try {
      firebaseAuth.signOut();
      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeBack()),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      print('$e');
      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => WelcomeBack()),
        (route) => false,
      );
    }
  }
}
