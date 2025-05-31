import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class Themeedata {
  static final ThemeData light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color.fromRGBO(238, 238,238, 1));
  static final ThemeData dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorsTheme.black.withAlpha(200), // Set background color

      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(color: ColorsTheme.white),
        bodyMedium: TextStyle(color: ColorsTheme.white),
        labelLarge: TextStyle(color: ColorsTheme.white),
        labelSmall: TextStyle(color: ColorsTheme.white),
        bodySmall: TextStyle(color: ColorsTheme.white),
        displayLarge: TextStyle(color: ColorsTheme.white),
        displayMedium: TextStyle(color: ColorsTheme.white),
        displaySmall: TextStyle(color: ColorsTheme.white),
        headlineLarge: TextStyle(color: ColorsTheme.white),
        headlineMedium: TextStyle(color: ColorsTheme.white),
        headlineSmall: TextStyle(color: ColorsTheme.white),
        labelMedium: TextStyle(color: ColorsTheme.white),
        titleLarge: TextStyle(color: ColorsTheme.white),
        titleMedium: TextStyle(color: ColorsTheme.white),
        titleSmall: TextStyle(color: ColorsTheme.white),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ColorsTheme.white),
        bodyMedium: TextStyle(color: ColorsTheme.white),
        labelLarge: TextStyle(color: ColorsTheme.white),
        labelSmall: TextStyle(color: ColorsTheme.white),
        bodySmall: TextStyle(color: ColorsTheme.white),
        displayLarge: TextStyle(color: ColorsTheme.white),
        displayMedium: TextStyle(color: ColorsTheme.white),
        displaySmall: TextStyle(color: ColorsTheme.white),
        headlineLarge: TextStyle(color: ColorsTheme.white),
        headlineMedium: TextStyle(color: ColorsTheme.white),
        headlineSmall: TextStyle(color: ColorsTheme.white),
        labelMedium: TextStyle(color: ColorsTheme.white),
        titleLarge: TextStyle(color: ColorsTheme.white),
        titleMedium: TextStyle(color: ColorsTheme.white),
        titleSmall: TextStyle(color: ColorsTheme.white),
      ));
}
