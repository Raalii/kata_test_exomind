import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeTextStyle {
  // All method return TextStyle
  static const String fontFamily = 'Outfit';

  static sectionTitle({fontSize = 36.0}) {
    return TextStyle(
      color: ColorsTheme.black,
      fontSize: fontSize * 1.0,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    );
  }

  static errorMessage() {
    return const TextStyle(
      fontFamily: fontFamily,
      color: ColorsTheme.red,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }
}
