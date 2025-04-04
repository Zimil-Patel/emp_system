import 'package:flutter/material.dart';

const primaryColor = Color(0xff73ab6b);

class AppTheme{
  static final lightTheme = ThemeData(
    fontFamily: 'VarelaRounded',
    scaffoldBackgroundColor: Colors.white,

    // APP BAR THEME
    appBarTheme: AppBarTheme(
      color: primaryColor,
      centerTitle: true,
    ),

    datePickerTheme: DatePickerThemeData(
      todayBackgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor; // ✅ Selected date background → primaryColor
          }
          return Colors.white; // ✅ Non-selected dates (including today) → White
        },
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      headerBackgroundColor: primaryColor,


      dayStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return TextStyle(color: Colors.white);
        }
        return TextStyle(color: Colors.black);
      }),


      dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor; // ✅ Selected date background → primaryColor
        }
        return Colors.white; // ✅ Non-selected dates (including today) → White
      }),

      todayBorder: BorderSide(color: primaryColor, width: 2),
      todayForegroundColor: MaterialStateProperty.resolveWith(
            (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white; // ✅ Selected date background → primaryColor
          }
          return primaryColor; // ✅ Non-selected dates (including today) → White
        },
      ),

      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: Colors.green,
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: Colors.red,
      ),
    ),

  );
}