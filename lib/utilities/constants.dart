import 'package:flutter/material.dart';

class Constant{
  static const Color primaryColor = Color(0xff4b005e);
  static const Color lightPrimaryColor = Color(0xff8932a8);
  static const Color accentColor = Color(0xff37005e);

  static const EdgeInsets defaultScreenPadding = EdgeInsets.symmetric(horizontal: 30);

  static const double defaultFontSize = 20.0;

  static const mainScreenNavigationUnFocusedTextStyle = TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );
  static const mainScreenNavigationFocusedTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );
}
