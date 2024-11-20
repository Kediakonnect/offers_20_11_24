import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final Color? borderColor;
  final String text;
  const BorderedText({super.key, this.borderColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor ?? ColorPalette.green,
        ),
      ),
      child: Text(
        text,
        style: AppTextThemes.theme(context).bodyMedium?.copyWith(
              color: borderColor ?? ColorPalette.green,
            ),
      ),
    );
  }
}
