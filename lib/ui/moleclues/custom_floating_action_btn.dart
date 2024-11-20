import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final Color? backgroundColor; // Optional background color

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor, // Accept optional background color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: ColorPalette.shadowOuterDark,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ??
                    ColorPalette
                        .primaryColor, // Default to ColorPalette.primaryColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: Icon(icon, color: ColorPalette.scaffoldBackgroundColor),
              label: Text(
                label,
                style: AppTextThemes.theme(context).headlineLarge?.copyWith(
                      color: ColorPalette.scaffoldBackgroundColor,
                    ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ??
                    ColorPalette
                        .primaryColor, // Default to ColorPalette.primaryColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                label,
                style: AppTextThemes.theme(context).displayMedium?.copyWith(
                      color: ColorPalette.scaffoldBackgroundColor,
                    ),
              ),
            ),
    );
  }
}
