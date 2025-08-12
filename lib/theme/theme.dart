import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
  scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
  dividerTheme: DividerThemeData(color: Colors.white24),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 17, 17, 17),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
  ),
);
