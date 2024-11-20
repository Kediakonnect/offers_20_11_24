import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';

class OutlinedContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  const OutlinedContainer(
      {super.key, required this.child, this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
