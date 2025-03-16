import 'package:flutter/material.dart';

const primaryColor = Color(0xff73ab6b);

class AppTheme{
  static final lightTheme = ThemeData(
    fontFamily: 'VarelaRounded',
    scaffoldBackgroundColor: Colors.white,

    // APP BAR THEME
    appBarTheme: AppBarTheme(
      color: primaryColor,
    ),

  );
}