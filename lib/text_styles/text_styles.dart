import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle body(
      {Color? color,
      double size = 18,
      FontWeight fontWeight = FontWeight.bold}) {
    return GoogleFonts.montserrat(
        fontSize: size,
        color: color,
        letterSpacing: 0.1,
        fontWeight: fontWeight);
  }
}
