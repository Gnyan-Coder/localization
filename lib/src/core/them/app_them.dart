import 'package:flutter/material.dart';

///This class defines light theme and dark theme
///Here we used flex color scheme
class Themes {
  static ThemeData get lightTheme => _buildLightTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.red));
  }

  static ThemeData get darkTheme => _buildDarkTheme();
  static ThemeData _buildDarkTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black));
  }
}
