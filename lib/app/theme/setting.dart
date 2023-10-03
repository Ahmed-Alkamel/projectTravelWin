import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color.dart';

class SettingsService extends GetxService {
  final isHover = false.obs;
  // GetStorage? box;

  // SettingsService() {
  //   box = GetStorage();
  // }
  Future<SettingsService> init() async {
    return this;
  }

  // ThemeMode getThemeMode() {
  //   //sString? themeMode = GetStorage().read<String>('theme_mode');

  // }

  ThemeData getDarkTheme() {
    return ThemeData(
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          mainAxisMargin: 5,
          trackColor: MaterialStateProperty.all(Colors.yellowAccent),
        ),
        primaryColorLight: Colors.black,
        primaryColor: DefaultColor.primaryColor,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: DefaultColor.primarySchemaColor,
        brightness: Brightness.dark,
        dividerColor: DefaultColor.dividerColor,
        // focusColor: Ui.parseColor(setting.value.accentDarkColor!),
        // hintColor: Ui.parseColor(setting.value.secondDarkColor!),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: DefaultColor.foragrandColor),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            //fontFamily: 'cailbri',
            fontSize: 21,
            fontWeight: FontWeight.bold,
            // color: Ui.parseColor(setting.value.mainDarkColor!)
          ),
          titleLarge: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: DefaultColor.textPrimary,
              height: 1.3),
          titleSmall: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              //  color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.2),
          titleMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              // color: Ui.parseColor(setting.value.mainDarkColor!),
              height: 1.2),
          headlineSmall: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              // color: Ui.parseColor('#FFFFFF'),
              height: 1.3),
          //  headline5: TextStyle(
          // fontSize: 16.0,
          // fontWeight: FontWeight.w700,
          // color: Ui.parseColor(setting.value.secondDarkColor!),
          // height: 1.3),
          headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              // color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.3),
          // headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.secondDarkColor!), height: 1.3),
          displaySmall: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              // color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.3),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              // color: Ui.parseColor(setting.value.mainDarkColor!),
              height: 1.4),
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              // color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.4),

          bodyMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              //   color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.2),
          bodyLarge: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              // color: Ui.parseColor(setting.value.secondDarkColor!),
              height: 1.2),
          bodySmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              //    color: Ui.parseColor(setting.value.accentDarkColor!),
              height: 1.2),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return DefaultColor.thumbDarkColor;
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return DefaultColor.trackDarkColor;
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return DefaultColor.primaryColor;
            }
            return null;
          }),
        ),
        dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        checkboxTheme: const CheckboxThemeData(
            //   fillColor: MaterialStateProperty.resolveWith<Color?>(
            //       (Set<MaterialState> states) {
            //     if (states.contains(MaterialState.disabled)) {
            //       return null;
            //     }
            //     if (states.contains(MaterialState.selected)) {
            //       return Ui.parseColor(setting.value.mainDarkColor!);
            //     }
            //     return null;
            //   }),
            ),
        colorScheme: const ColorScheme.dark(
          primary: DefaultColor.primaryColor,
          secondary: DefaultColor.sencondreColor,
        )
            .copyWith(
              secondary: DefaultColor.primaryColor,
            )
            .copyWith(background: Colors.yellow));
  }

  ThemeData getLightTheme() {
    return ThemeData(
        // fontFamily: GoogleFonts.roboto().fontFamily,
        navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: DefaultColor.primaryColor),
        useMaterial3: true,
        appBarTheme: Get.theme.appBarTheme
            .copyWith(backgroundColor: DefaultColor.primaryColor),
        secondaryHeaderColor: DefaultColor.sencondreColor,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.black),
          mainAxisMargin: 5,
          trackColor: MaterialStateProperty.all(Colors.white),
        ),
        primaryColorLight: Colors.green,
        // fontFamily: 'AdobeAr',
        iconTheme: const IconThemeData(color: DefaultColor.primaryColor),
        primaryColor: Colors.white,
        focusColor: DefaultColor.primarySchemaColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            //  backgroundColor: Color.fromARGB(255, 243, 231, 231),
            elevation: 0,
            foregroundColor: Colors.white),
        scaffoldBackgroundColor: DefaultColor.primarySchemaColor,
        brightness: Brightness.light,
        dividerColor: DefaultColor.dividerLightColor,
        // focusColor: Ui.parseColor(setting.value.accentColor!),
        // hintColor: Ui.parseColor(setting.value.secondColor!),
        dialogBackgroundColor: DefaultColor.primarySchemaColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              //   foregroundColor: Ui.parseColor(setting.value.mainColor!)
              ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: DefaultColor.textSecandry,
          ),
          headlineSmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: DefaultColor.textSecandry,
              height: 1.3),
          headlineMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: DefaultColor.textSecandry,
              height: 1.3),
          titleLarge: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: DefaultColor.textPrimary,
              height: 1.3),
          titleSmall: TextStyle(
              fontSize: 12.0, color: DefaultColor.textPrimary, height: 1.2),
          titleMedium: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: DefaultColor.textPrimary,
              height: 1.2),
          displaySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: DefaultColor.textSecandry,
              height: 1.3),
          displayMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: DefaultColor.textPrimary,
              height: 1.3),
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              //  color: Colors.white,
              //   color: Ui.parseColor(setting.value.mainColor!),
              height: 1.4),
          bodyMedium: TextStyle(
              fontSize: 12.0,
              // fontWeight: FontWeight.w600,
              color: DefaultColor.textPrimary,
              height: 1.2),
          bodyLarge: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: DefaultColor.textPrimary,
              height: 1.2),
          bodySmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              // color: Ui.parseColor(setting.value.accentColor!),
              height: 1.2),
        ),
        colorScheme: const ColorScheme.light(
          primary: DefaultColor.primaryColor,
          secondary: DefaultColor.primarySchemaColor,
        )
            .copyWith(secondary: DefaultColor.primarySchemaColor)
            .copyWith(background: Colors.white),
        bottomAppBarTheme:
            const BottomAppBarTheme(color: Color.fromARGB(255, 64, 220, 255)));
  }
}
