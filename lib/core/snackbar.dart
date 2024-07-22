import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';

class AppSnackBar {
  static error(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
    ));
  }

  static success(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: AppColor.primaryColor,
    ));
  }
}
