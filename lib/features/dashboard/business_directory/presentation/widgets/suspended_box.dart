import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/text_themes/text_themes.dart';

class SuspendedBox extends StatelessWidget {
  final String message;
  final VoidCallback onDetailTap;
  const SuspendedBox(
      {super.key, required this.message, required this.onDetailTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorPalette.red,
          )),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            message,
            style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                  color: ColorPalette.red,
                ),
          ),
          CustomSpacers.height10,
          TextButton(
            onPressed: onDetailTap,
            child: Text(
              'See Details',
              style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                    color: ColorPalette.primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
