import 'package:flutter/material.dart';

class ReportTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodyText1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      primaryColor: Colors.blue,
      disabledColor: Colors.grey,
      // brightness: Brightness.light,
      // checkboxTheme: CheckboxThemeData(
      //   fillColor: MaterialStateColor.resolveWith(
      //     (states) {
      //       return Colors.black;
      //     },
      //   ),
      // ),
      // appBarTheme: const AppBarTheme(
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.blue,
      // ),
      // textButtonTheme: TextButtonThemeData(
      //   style:
      // ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   selectedItemColor: Colors.green,
      // ),
      textTheme: lightTextTheme,
    );
  }
}
