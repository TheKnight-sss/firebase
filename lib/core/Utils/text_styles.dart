import 'package:bookia/core/Utils/colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle styleSize30({
    Color? color,
    double fontSize = 30,
    FontWeight fontweight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }

  static TextStyle styleSize24({
    Color? color,
    double fontSize = 24,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }

  static TextStyle styleSize20({
    Color? color,
    double fontSize = 20,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }

  static TextStyle styleSize18({
    Color? color,
    double fontSize = 18,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }

  static TextStyle styleSize16({
    Color? color,
    double fontSize = 16,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }

  static TextStyle styleSize14({
    Color? color,
    double fontSize = 14,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color ?? AppColor.darkColor,
    );
  }
}
