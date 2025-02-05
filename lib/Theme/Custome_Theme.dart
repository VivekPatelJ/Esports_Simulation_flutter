import 'package:flutter/material.dart';

class CustomeTheme {
   static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100,
    primary: Colors.redAccent.shade700,
    primaryContainer: Colors.redAccent.shade400,
    secondary: Colors.tealAccent.shade700,
    secondaryContainer: Colors.tealAccent.shade400,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    error: Colors.deepOrange.shade700,
    onError: Colors.white,
    ),
  );

  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Colors.redAccent.shade200,
    primaryContainer: Colors.redAccent.shade400,
    secondary: Colors.tealAccent.shade400,
    secondaryContainer: Colors.tealAccent.shade700,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    error: Colors.orangeAccent.shade700,
    onError: Colors.black,
    )
  );
}
