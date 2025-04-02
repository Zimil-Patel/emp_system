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

    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      headerBackgroundColor: primaryColor,
      dayStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return TextStyle(color: Colors.white); // Selected day text color
        }
        return TextStyle(color: Colors.black); // Default day text color
      }),

      dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor; // Selected day background color (circle)
        }
        return null; // Default background
      }),

      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: Colors.green, // OK button text color
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: Colors.red, // Cancel button text color
      ),
    ),

  );
}