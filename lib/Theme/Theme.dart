import 'package:flutter/material.dart';

class AppTheme {
  static Color scaffoldBackgroundColor = Color(0xff101113);
  static Color primaryColor = Color(0xfff36f42);
  static Color elevatedButtonPrimaryColor = Color(0xfff36f42);
  static Color elevatedButtonBorderColor = Colors.transparent;
  static Color elevatedButtonTextColor = Colors.white;
  static Color appBarBackgroundColor = Color(0xff101113);
  static Color appBarForegroundColor = Colors.white;
  static Color bodyTextColor = Colors.white;
  static Color headline3Color = Colors.black;
  static Color iconColor = Color(0xff979797);
  static Color greyColor = Color(0xff747688);
  static Color blackColor = Colors.black;

  double buttonLetterSpacing = 1;


  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBackgroundColor,
      elevation: 0,
      foregroundColor: appBarForegroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //primary: Color(0xff1b1d28),
        primary: elevatedButtonPrimaryColor,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: elevatedButtonBorderColor,
          ),
        ),
      ),
    ),
    primaryIconTheme: IconThemeData(color: iconColor),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: bodyTextColor,
      ),
      headline3: TextStyle(color: headline3Color, fontWeight: FontWeight.bold),
      button: TextStyle(
        color: elevatedButtonTextColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: 21
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(
        color: greyColor,
        fontWeight: FontWeight.w300,
      ),
      labelStyle: TextStyle(
        color: blackColor
      )
    )
  );
}
