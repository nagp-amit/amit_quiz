import 'package:flutter/material.dart';
import '../colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Metropolis',
  primarySwatch: mainColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    titleSpacing: 20,
    color: Colors.white,
    //backwardsCompatibility: false,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);