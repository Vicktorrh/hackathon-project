import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class AppUpload {
  static final uploadImage = FirebaseStorage.instance.ref();

  static Future<String?> uploadImages(
    String folderName,
    File image,
    String id,
  ) async {
    try {
      var uploadIm = uploadImage.child('$folderName/$id.png');
      var storageref = await uploadIm.putFile(image);
      var downloadUrl = await storageref.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
  }
}
