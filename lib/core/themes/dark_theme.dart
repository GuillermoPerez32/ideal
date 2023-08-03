import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    primary: Colors.black,
    secondary: Colors.orange,
  ),
  scaffoldBackgroundColor: Colors.grey[850],
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      color: Colors.grey[500],
    ),
  ),
);
