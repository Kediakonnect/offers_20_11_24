import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/buttom_themes/elevated_button_theme.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: ColorPalette.scaffoldBackgroundColor,
    ),
    textTheme: AppTextThemes.lightTextTheme,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorPalette.scaffoldBackgroundColor,
    elevatedButtonTheme: ElevatedButtontheme.lightElevatedButtonTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: AppTextThemes.lightTextTheme.displayLarge?.copyWith(
        color: ColorPalette.scaffoldBackgroundColor,
        fontSize: 15.sp,
      ),
    ),
  );
}
