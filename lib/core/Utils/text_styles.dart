import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle headLine({
    Color? color,
    double fontSize = 24,
    FontWeight fontweight = FontWeight.bold,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }

  static TextStyle subHeadline({
    Color? color,
    double fontSize = 20,
    FontWeight fontweight = FontWeight.bold,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }

  static TextStyle title({
    Color? color,
    double fontSize = 18,
    FontWeight fontweight = FontWeight.bold,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }

  static TextStyle body({
    Color? color,
    double fontSize = 16,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }

  static TextStyle small({
    Color? color,
    double fontSize = 14,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }

  static TextStyle caption({
    Color? color,
    double fontSize = 12,
    FontWeight fontweight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontweight, color: color);
  }
}
