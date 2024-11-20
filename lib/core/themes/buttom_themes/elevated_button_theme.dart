import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';

class ElevatedButtontheme {
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shadowColor: ColorPalette.shadowOuterDark,
      backgroundColor: ColorPalette.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      textStyle: AppTextThemes.lightTextTheme.headlineLarge?.copyWith(
        color: ColorPalette.scaffoldBackgroundColor,
      ),
    ),
  );
}
