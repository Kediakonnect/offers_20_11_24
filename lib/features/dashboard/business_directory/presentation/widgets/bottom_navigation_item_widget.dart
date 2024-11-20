import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationItem extends StatefulWidget {
  final String assetName, text;
  final VoidCallback onTap;

  const BottomNavigationItem({
    super.key,
    required this.assetName,
    required this.text,
    required this.onTap,
  });

  @override
  _BottomNavigationItemState createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {
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
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const offset = Offset(4, 4);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 46.h,
        width: 66.w,
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
          boxShadow: isPressed
              ? [
                  // Inner shadow when pressed
                  BoxShadow(
                    offset: -offset,
                    color: ColorPalette.bottomNavigatorLightShadow,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                  const BoxShadow(
                    offset: offset,
                    color: ColorPalette.bottomNavigatorDarkShadow,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : [
                  // Outer shadow when idle
                  const BoxShadow(
                    offset: offset,
                    color: ColorPalette.bottomNavigatorDarkShadow,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    offset: -offset,
                    color: ColorPalette.bottomNavigatorLightShadow,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.assetName,
              height: 20.h,
              width: 20.h,
            ),
            CustomSpacers.height4,
            Text(
              widget.text,
              style: TextStyle(
                color: ColorPalette.scaffoldBackgroundColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
