import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/dasboard_options.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashBoardOptionCard extends StatelessWidget {
  final String assetName, text;
  final VoidCallback onPressed;
  final bool? isSelected;
  const DashBoardOptionCard(
      {super.key,
      required this.assetName,
      required this.text,
      this.isSelected = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.all(5),
        height: 65.h,
        color: isSelected! ? ColorPalette.primaryColor : null,
        width: 65.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (text == DashBoardOptions.more.title)
              SvgPicture.asset(
                DashBoardOptions.more.assetName,
                width: 28.w,
                height: 28.h,
              )
            else
              Image.asset(
                assetName,
                height: 28.h,
                width: 28.w,
                color:
                    isSelected! ? ColorPalette.scaffoldBackgroundColor : null,
              ),
            CustomSpacers.height4,
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text,
              style: AppTextThemes.theme(context).titleSmall?.copyWith(
                  color: isSelected!
                      ? ColorPalette.scaffoldBackgroundColor
                      : ColorPalette.textDark,
                  fontSize: 10.sp),
              softWrap: true,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
