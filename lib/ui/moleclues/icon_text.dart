import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconText extends StatelessWidget {
  final String assetName, text;
  final TextStyle? style;
  const IconText(
      {super.key, required this.assetName, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(assetName),
        // CustomSpacers.width10,
        Text(' $text', style: style ?? AppTextThemes.theme(context).bodyMedium),
      ],
    );
  }
}
