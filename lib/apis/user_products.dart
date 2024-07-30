import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/core/snackbar.dart';

class UserProducts {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addtoWishlist(String docId, Map<String, dynamic> product) async {
    try {
      List listOfWishList = product['wishlist'];

      if (!listOfWishList.contains(FirebaseAuth.instance.currentUser!.uid)) {
        listOfWishList.add(FirebaseAuth.instance.currentUser!.uid);
        await firebaseFirestore
            .collection('product')
            .doc(docId)
            .update({"wishlist": listOfWishList});
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('wishlist')
            .doc(docId)
            .set(product);
      } else {
        listOfWishList.remove(FirebaseAuth.instance.currentUser!.uid);
        await firebaseFirestore
            .collection('product')
            .doc(docId)
            .update({"wishlist": listOfWishList});
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('wishlist')
            .doc(docId)
            .delete();
      }
    } on FirebaseException catch (e) {}
  }

  Future addtoCart(String docId, Map<String, dynamic> wishlist) async {
    try {
      wishlist['productCount'] = 1;
      wishlist['totalPrice'] = wishlist['price'];
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('wishlist')
          .doc(docId)
          .delete();

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(docId)
          .set(wishlist);

      var docs = await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var data = docs.data()!['totalPrice'];
      var totalPrice = data + wishlist['price'];

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'totalPrice': totalPrice});
    } on FirebaseException catch (e) {}
  }

  Future increaseCurrentProduct(
      String docId, Map<String, dynamic> wishlist) async {
    try {
      wishlist['productCount'] += 1;
      wishlist['totalPrice'] += wishlist['price'];
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(docId)
          .set(wishlist);

      var docs = await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var data = docs.data()!['totalPrice'];
      var totalPrice = data + wishlist['price'];

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'totalPrice': totalPrice});
    } on FirebaseAuthException catch (e) {}
  }

  Future decreaseCurrentProduct(
      BuildContext context, String docId, Map<String, dynamic> wishlist) async {
    try {
      if (wishlist['productCount'] > 1) {
        wishlist['productCount'] -= 1;
        wishlist['totalPrice'] -= wishlist['price'];
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(docId)
            .set(wishlist);

        var docs = await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var data = docs.data()!['totalPrice'];
        var totalPrice = data - wishlist['price'];

        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'totalPrice': totalPrice});
      } else {
        AppSnackBar.error(context, 'You can have less than 1');
      }
    } on FirebaseAuthException catch (e) {}
  }

  Future deleteCart(
      String docId, Map<String, dynamic> wishlist, List product) async {
    try {
      if (product.length == 1) {
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(docId)
            .delete();

        var docs = await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var data = docs.data()!['totalPrice'];
        var totalPrice = data - wishlist['totalPrice'];

        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'totalPrice': 0});
      } else {
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(docId)
            .delete();

        var docs = await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var data = docs.data()!['totalPrice'];
        var totalPrice = data - wishlist['totalPrice'];

        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'totalPrice': totalPrice});
      }
    } on FirebaseException catch (e) {}
  }

  Future addOrder(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> wishlist) async {
    try {
      for (var element in wishlist) {
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .doc(element.data()["productId"])
            .delete();
        await firebaseFirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('orders')
            .doc(element.data()["productId"])
            .set(element.data());
      }

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'totalPrice': 0});
    } on FirebaseException catch (e) {}
  }
}
