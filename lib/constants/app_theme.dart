import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsLight.backgroundColor,
    appBarTheme: const AppBarTheme(
        color: AppColorsLight.appBarColor,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.white)),
    tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xFF8DE1D1)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Color(0xFF151A1E),
      ),
      titleMedium: TextStyle(
        color: Color(0xFF82898F),
      ),
    ),
    listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
        leadingAndTrailingTextStyle: TextStyle(color: Color(0xFF82898F)),
        iconColor: Color(0xFF82898F),
        titleTextStyle: TextStyle(color: Color(0xFF151A1E)),
        subtitleTextStyle: TextStyle(color: Color(0xFF82898F))),
    cardColor: AppColorsLight.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColorsLight.backgroundColor,
      backgroundColor: AppColorsLight.appBarColor,
    ),
  );
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColorsDark.backgroundColor,
      appBarTheme: const AppBarTheme(
          color: AppColorsDark.appBarColor,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.white)),
      tabBarTheme: const TabBarTheme(
          indicatorColor: Color(0xFF119E7E),
          labelColor: Color(0xFF119E7E),
          unselectedLabelColor: Color(0xFF828F97)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Color(0xFFEAF1F7),
        ),
        titleMedium: TextStyle(
          color: Color(0xFF828F97),
        ),
      ),
      cardColor: AppColorsDark.backgroundColor,
      listTileTheme: const ListTileThemeData(
          tileColor: AppColorsDark.backgroundColor,
          leadingAndTrailingTextStyle: TextStyle(color: Color(0xFF828F97)),
          iconColor: Color(0xFF828F97),
          titleTextStyle: TextStyle(color: Color(0xFFEAF1F7)),
          subtitleTextStyle: TextStyle(color: Color(0xFF828F97))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColorsDark.backgroundColor,
        backgroundColor: Color(0xFF119E7E),
      ));
}
