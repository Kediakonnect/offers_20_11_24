import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final String btnText;
  final double? borderRadius;
  final double? height;
  final double? width;
  final bool? isLoading;
  final VoidCallback onPressed;
  final Color? backgroundColor, textColor;

  const CustomButton({
    super.key,
    this.textColor = ColorPalette.scaffoldBackgroundColor,
    required this.onPressed,
    this.backgroundColor = ColorPalette.primaryColor,
    required this.btnText,
    this.isLoading = false,
    this.height = FigmaValueConstants.btnHeight,
    this.width = FigmaValueConstants.btnWidth,
    this.borderRadius = FigmaValueConstants.btnBorderRadius,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isPressed = false;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(widget.borderRadius!),
            ),
            depth:
                isPressed ? -8 : 8, // Increase outer shadow and emboss effect
            intensity: isPressed
                ? 0.7
                : 0.5, // Keep intensity slightly higher for pressed state
            lightSource: LightSource.topLeft,
            shadowLightColor: Colors.white
                .withOpacity(0.8), // Optional: fine-tune light shadow color
            shadowDarkColor: Colors.black
                .withOpacity(0.75), // Increase shadow darkness for more depth
            color: widget.backgroundColor, // Neumorphic surface color
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: widget.height!.h,
            width: widget.width!.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorPalette.scaffoldBackgroundColor,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: widget.isLoading!
                ? const Loading(
                    color: ColorPalette.scaffoldBackgroundColor,
                  )
                : Text(
                    widget.btnText,
                    textAlign: TextAlign.center,
                    style: AppTextThemes.theme(context)
                        .headlineLarge
                        ?.copyWith(color: widget.textColor),
                  ),
          ),
        ),
      ),
    );
  }
}
