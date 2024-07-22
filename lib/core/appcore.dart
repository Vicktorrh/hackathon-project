import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppCore {
  static Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    var file = await picker.pickImage(source: source);

    if (file == null) {
      return null;
    } else {
      File image = File(file.path);
      return image;
    }
  }
}
