import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';

class NeuroMorphicContainer extends StatelessWidget {
  final double? height, width, borderRadius;
  final BoxShape? shape;
  final Color? color;
  final EdgeInsets? padding;
  final Widget? child;
  final bool? isSharpWhite;
  const NeuroMorphicContainer({
    super.key,
    this.height,
    this.padding,
    this.shape,
    this.color = ColorPalette.scaffoldBackgroundColor,
    this.child,
    this.width,
    this.borderRadius,
    this.isSharpWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? EdgeInsets.zero,
      width: width,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: color ?? ColorPalette.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.18),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            offset: const Offset(-2, -4),
            color: isSharpWhite != null
                ? Colors.white.withOpacity(0.95)
                : Colors.white.withOpacity(0.60),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        borderRadius:
            shape == null ? BorderRadius.circular(borderRadius ?? 8) : null,
      ),
      child: child,
    );
  }
}
