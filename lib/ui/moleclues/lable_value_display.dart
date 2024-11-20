import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  final String label, value;
  const LabelValueWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: AppTextThemes.theme(context).headlineLarge,
          ),
          TextSpan(
            text: value,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ],
      ),
    );
  }
}
