import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';

class FigmaValueConstants {
  static const double screenHeight = 800;
  static const double screenWidth = 360;
  static const double btnBorderRadius = 10;
  static const double btnHeight = 55;
  static const double btnWidth = 280;
  static const double radioHeight = 21;
  static const double dropDownHeight = 48;
  static const double dropDownWidth = 280;

  static const double defaultPaddingH = 40;

  static const textShadow = [
    BoxShadow(
      color: ColorPalette.bottomNavigatorDarkShadow, // Color with opacity
      offset: Offset(1, 1), // Horizontal and vertical offset
      blurRadius: 1, // Blur radius
      spreadRadius: 0, // Spread radius
    ),
  ];
  static const boxShadow = [
    BoxShadow(
      offset: Offset(2, 4),
      color: ColorPalette.shadowOuterDark,
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      offset: Offset(-2, -4),
      color: ColorPalette.shadowOuterLight,
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static var neuromorphicDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(12),
    color: ColorPalette.scaffoldBackgroundColor,
    boxShadow: const [
      BoxShadow(
        offset: Offset(2, 4),
        color: ColorPalette.shadowOuterDark,
        blurRadius: 4,
        spreadRadius: 0,
      ),
      BoxShadow(
        offset: Offset(-2, -4),
        color: ColorPalette.shadowOuterLight,
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );
}
