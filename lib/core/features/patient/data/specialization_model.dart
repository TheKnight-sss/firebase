import 'package:fire/core/features/auth/models/specialization.dart';
import 'package:flutter/material.dart';

/// Color palette
const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);

const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);

const Color purple = Color(0xff8873f4);
const Color purpleLight = Color(0xff9489f4);

const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3);

/// Reusable immutable model for specialization cards.
class SpecializationCardModel {
  final String specialization;
  final Color cardBackground;
  final Color cardLightColor;

  const SpecializationCardModel({
    required this.specialization,
    required this.cardBackground,
    required this.cardLightColor,
  });

  @override
  String toString() =>
      'SpecializationCardModel($specialization, $cardBackground, $cardLightColor)';
}

/// A small palette of color pairs to cycle through when generating cards.
const List<List<Color>> _colorPairs = [
  [skyBlue, lightBlue],
  [green, lightGreen],
  [orange, lightOrange],
  [purple, purpleLight],
];

/// Generates a list of specialization card models from a list of names.
/// This handles any length by cycling through the available color pairs.
List<SpecializationCardModel> createSpecializationCards(List<String> names) {
  return List<SpecializationCardModel>.generate(
    names.length,
    (index) {
      final pair = _colorPairs[index % _colorPairs.length];
      return SpecializationCardModel(
        specialization: names[index],
        cardBackground: pair[0],
        cardLightColor: pair[1],
      );
    },
    growable: false,
  );
}

/// Example: build cards from the imported `specialization` list.
final List<SpecializationCardModel> cards = createSpecializationCards(specialization);