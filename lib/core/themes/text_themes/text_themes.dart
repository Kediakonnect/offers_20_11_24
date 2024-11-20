import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextThemes {
  static TextTheme Function(BuildContext) get theme =>
      (BuildContext context) => Theme.of(context).textTheme;

  static TextTheme lightTextTheme = TextTheme(
    //! display contains all font size of weight 700
    displayLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: ColorPalette.textDark,
    ),
    displayMedium: TextStyle(
      fontSize: 14.sp,
      color: ColorPalette.textDark,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 13.sp,
      fontWeight: FontWeight.w700,
    ),

    //! headline contains all font size of weight 600
    headlineLarge: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.sp,
      color: ColorPalette.textDark,
      fontWeight: FontWeight.w600,
    ),

    //! title contains all font size of weight 500

    titleLarge: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    //! body contains all font size of weight 400
    bodyLarge: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: ColorPalette.textDark,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}
