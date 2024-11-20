import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({super.key, this.color = ColorPalette.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
