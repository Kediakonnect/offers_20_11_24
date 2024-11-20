import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBadge extends StatelessWidget {
  final Color? color;
  final String text;

  const CustomBadge({super.key, this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 25.w),
      child: Text(
        text,
        style: AppTextThemes.lightTextTheme.bodySmall!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
