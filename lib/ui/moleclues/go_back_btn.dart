import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const NeuroMorphicText(
        text: 'Go Back',
        fontSize: 16,
        color: ColorPalette.primaryColor,
      ),
    );
  }
}
