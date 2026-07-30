import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.deepOrange,
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepOrange,
    useMaterial3: true,
  );
}