import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/ui/atoms/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onMenuTap;
  final IconData? icon;
  const MenuButton({
    super.key,
    required this.onMenuTap,
    this.icon = Icons.menu,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onMenuTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        height: 34.h,
        width: 34.h,
        decoration: const BoxDecoration(
          color: ColorPalette.primaryColor,
          shape: BoxShape.circle,
          boxShadow: FigmaValueConstants.boxShadow,
        ),
        child: Icon(
          icon,
          color: ColorPalette.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
