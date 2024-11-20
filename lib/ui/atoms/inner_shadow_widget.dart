import 'dart:ui';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.blur = 4,
    this.topLeftColor = ColorPalette.shadowInnerDark,
    this.bottomRightColor = ColorPalette.shadowInnerLight,
    this.offset = const Offset(8, 8),
    super.child,
  });

  final double blur;
  final Color topLeftColor;
  final Color bottomRightColor;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInnerShadow()
      ..blur = blur
      ..topLeftColor = topLeftColor
      ..bottomRightColor = bottomRightColor
      ..dx = offset.dx
      ..dy = offset.dy;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject
      ..blur = blur
      ..topLeftColor = topLeftColor
      ..bottomRightColor = bottomRightColor
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double blur = 10;
  Color topLeftColor = const Color.fromRGBO(0, 0, 0, 0.1);
  Color bottomRightColor = const Color.fromRGBO(255, 255, 255, 0.35);
  double dx = 10;
  double dy = 10;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Rect rectOuter = offset & size;
    // final Rect rectInner = Rect.fromLTWH(
    //   offset.dx + dx,
    //   offset.dy + dy,
    //   size.width - 2 * dx,
    //   size.height - 2 * dy,
    // );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);

    final Paint topLeftShadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
      ..colorFilter = ColorFilter.mode(topLeftColor, BlendMode.srcOut);

    final Paint bottomRightShadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
      ..colorFilter = ColorFilter.mode(bottomRightColor, BlendMode.srcOut);

    // Apply top-left shadow
    canvas
      ..saveLayer(rectOuter, topLeftShadowPaint)
      ..translate(-dx, -dy);
    context.paintChild(child!, offset);
    canvas.restore();

    // Apply bottom-right shadow
    canvas
      ..saveLayer(rectOuter, bottomRightShadowPaint)
      ..translate(dx, dy);
    context.paintChild(child!, offset);
    canvas.restore();

    canvas.restore();
  }
}
