import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColor.whiteColor,
    primaryColor: AppColor.primaryColor,
    fontFamily: AppFonts.cairo,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.whiteColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      onSurface: AppColor.darkColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.accentColor,
      prefixIconColor: AppColor.primaryColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColor.accentColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red.shade700),
      ),
      filled: true,
      hintStyle: TextStyles.small,
    ),
  );
}
