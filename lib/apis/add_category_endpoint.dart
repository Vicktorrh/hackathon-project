import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathanproject/apis/upload_image.dart';
import 'package:uuid/uuid.dart';

class AddCategoryEndpoint {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addCategory(
      String categoryName, String categoryDescription, File image) async {
    try {
      String id = const Uuid().v4();
      var url = await AppUpload.uploadImages('category', image, id);
      if (url != null) {
        firebaseFirestore.collection('category').doc(id).set({
          'categoryName': categoryName,
          'categoryDescription': categoryDescription,
          'categoryUrl': url
        });
      }
    } on FirebaseException catch (e) {}
  }
}

class AddProductsEndpoint {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addProducts(String productName, String productDescription,
      String price, File image, String productCategory) async {
    try {
      String id = const Uuid().v4();
      var url = await AppUpload.uploadImages('product', image, id);
      if (url != null) {
        firebaseFirestore.collection('product').doc(id).set({
          'productName': productName,
          'productDescription': productDescription,
          'price': int.tryParse(price),
          'productCategory': productCategory,
          'productUrl': url
        });
      }
    } on FirebaseException catch (e) {}
  }
}
