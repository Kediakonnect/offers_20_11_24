import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuroMorphicText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  const NeuroMorphicText(
      {super.key,
      required this.text,
      this.fontWeight,
      this.fontSize,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        shadows: FigmaValueConstants.textShadow,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 14.sp,
        color: color ?? ColorPalette.primaryColor,
      ),
    );
  }
}
