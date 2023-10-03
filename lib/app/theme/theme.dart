import 'package:flutter/material.dart';

import 'color.dart';

Map<int, Color> myColor = {
  1: DefaultColor.primaryColor,
  2: DefaultColor.sencondreColor,
};

final ThemeData appThemData = ThemeData(
  dividerColor: DefaultColor.primaryColor,
  dividerTheme: const DividerThemeData(
    color: DefaultColor.primaryColor,
    thickness: 1,
    space: 1,
  ),
  timePickerTheme: const TimePickerThemeData(
    dialBackgroundColor: DefaultColor.primaryColor,
    dialHandColor: DefaultColor.primaryColor,
  ),
  primarySwatch: DefaultColor.materialColorPrimary,
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(
      color: DefaultColor.textSecandry,
      fontWeight: FontWeight.bold,
    ),
    labelColor: DefaultColor.textSecandry,
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    unselectedLabelColor: DefaultColor.textPrimary,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: DefaultColor.underlineTabBarColor,
      ),
    ),
  ),

  //List Tilter
  listTileTheme: const ListTileThemeData(
    style: ListTileStyle.drawer,
    selectedTileColor: DefaultColor.primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DefaultColor.primaryColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DefaultColor.primaryColor,
  ),
  // ignore: prefer_const_constructors
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DefaultColor.primaryColor,
    unselectedItemColor: const Color.fromARGB(85, 255, 255, 255),
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    type: BottomNavigationBarType.fixed,
  ),
);
double defaultSizeFont = 12;

class OptionThemeWidget {
  //labalMain
  static double labalMainTextSize = 12;
  static FontWeight lableMainFontWeight = FontWeight.bold;

  static double labalLogoTextSize = 25;
  static FontWeight lableLogoFontWeight = FontWeight.w800;

  //
  static double cardTextSize = 14;
  static FontWeight cardFontWeight = FontWeight.w800;
}
