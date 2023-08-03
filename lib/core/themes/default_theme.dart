import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    primary: Colors.black,
    secondary: Colors.orange,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      color: Colors.grey[500],
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
);
