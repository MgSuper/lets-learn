import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main color of the app
    scaffoldBackgroundColor: ColorManager.primary,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.secondaryPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    // ripple Color
    splashColor: ColorManager.secondaryPrimary,
    // Card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
        elevation: AppSize.s4,
        shadowColor: ColorManager.secondaryPrimary,
        titleTextStyle: getRegularStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s24,
        ),
        iconTheme: IconThemeData(color: ColorManager.primary)),
    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.secondaryPrimary,
    ),
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.secondaryPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text theme
    textTheme: TextTheme(
      displayLarge:
          getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s32),
      displayMedium:
          getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s32),
      titleMedium:
          getMediumtyle(color: ColorManager.lightgrey, fontSize: FontSize.s14),
      titleSmall:
          getMediumtyle(color: ColorManager.white, fontSize: FontSize.s12),
      labelMedium:
          getMediumtyle(color: ColorManager.white, fontSize: FontSize.s18),
      labelLarge:
          getMediumtyle(color: ColorManager.white, fontSize: FontSize.s28),
      labelSmall:
          getMediumtyle(color: ColorManager.white, fontSize: FontSize.s14),
      bodySmall: getRegularStyle(color: ColorManager.grey1),
      bodyLarge: getRegularStyle(color: ColorManager.grey),
    ),
    tabBarTheme: TabBarTheme(
        indicator: const BoxDecoration(),
        labelPadding: const EdgeInsets.only(
          left: 20.0,
        ),
        labelColor: ColorManager.primary),

    // Input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: ColorManager.white,
      focusColor: ColorManager.primary,
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.white),
      labelStyle: getMediumtyle(color: ColorManager.white),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.red,
      elevation: AppSize.s0,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.secondaryPrimary,
      selectedLabelStyle: getRegularStyle(color: ColorManager.primary),
      unselectedLabelStyle: getRegularStyle(
        color: ColorManager.secondaryPrimary,
      ),
    ),
  );
}
