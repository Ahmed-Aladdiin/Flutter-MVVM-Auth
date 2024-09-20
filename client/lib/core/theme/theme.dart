import 'package:client/core/theme/palette.dart';
import 'package:flutter/material.dart';

final authTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Palette.backgroundColor,
  appBarTheme: const AppBarTheme(color: Palette.backgroundColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(25),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 3, color: Palette.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 3, color: Palette.gradient2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 3, color: Palette.gradient3),
    )
  ),
);
