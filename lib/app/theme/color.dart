import 'package:flutter/material.dart';

class DefaultColor {
  static init() {
    materialColorPrimary = _generationColorMaterial(primaryColor);
  }

  static late MaterialColor materialColorPrimary;
  static const Color primaryColor = Color(0xFF0B2B40);

  // static const Color primaryColor = Color(0xFF2196F3);
  static const Color primarySchemaColor = Colors.white;
  static const Color doneColocr = Colors.greenAccent;
  static const Color canselColor = Colors.red;
  static const Color errorColor = Colors.red;

  static const Color containTheme1 = Color(0xFF1E5959);
  static const Color containTheme2 = Color(0xFF164773);
  static const Color containTheme3 = Color(0xFF3B8C6E);
  static const Color sencondreColor = Colors.black;
  static const Color textPrimary = Colors.white; //light
  static const Color textSecandry = primaryColor;
  static const Color colorIconPrimary = Colors.white;
  static const Color underlineTabBarColor = Colors.white;
  static const Color buttomDoneColor = DefaultColor.primaryColor;
  static const Color buttomCancelColor = Colors.black;
  static const Color dividerColor = Colors.black;
  static const Color foragrandColor = Colors.white;
  static const Color dividerLightColor = primaryColor;
  static const Color foragrandLightColor = Colors.white;
  static const Color thumbDarkColor = Colors.green;
  static const Color trackDarkColor = Colors.blueAccent;

  static MaterialColor _generationColorMaterial(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
