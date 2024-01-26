import 'package:flutter/material.dart';

class BrandFonts {
  static const String fontFamily = 'Poppins';

  static const double h1 = 15;

  static const double regularText = 12;

  static const double textButtonSize = 15;

  static TextStyle fontFamilyBold =
      const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold);

  static TextStyle fontFamilyRegular = const TextStyle(
    fontSize: BrandFonts.regularText,
    fontFamily: BrandFonts.fontFamily,
  );
}
