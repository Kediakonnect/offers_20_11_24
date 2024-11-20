import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureCardWidget extends StatelessWidget {
  const FeatureCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NeuroMorphicContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 20.h,
      ),
      width: double.infinity,
      borderRadius: 10.r,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "New Feature 1",
              style: AppTextThemes.lightTextTheme.headlineSmall!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
          ),
          CustomSpacers.height20,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.network(
              AppImages.feature,
              width: double.infinity,
              height: 160.h,
            ),
          ),
          CustomSpacers.height10,
          Text(
            "Check out details about this here",
            style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
              color: ColorPalette.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
