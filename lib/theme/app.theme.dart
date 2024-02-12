import 'package:flutter/material.dart';

class Apptheme {
  static const Color primary = Color.fromRGBO(26, 35, 126, 1);
  static const Color secondary = Color.fromRGBO(255,179,0, 1);
  static const Color darkGrey = Color.fromRGBO(66, 66, 66, 1);
  static const Color redAlert = Color.fromRGBO(211,47,47, 1);
  static const Color white = Color.fromRGBO(255,255,255, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    
    // Primary color
    primaryColor: primary,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      color: primary,
      elevation: 0
    ),

  );
}