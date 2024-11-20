import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback? onTap;

  const ProfileContainer({
    super.key,
    required this.child,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeuroMorphicContainer(
      width: double.infinity,
      padding: EdgeInsets.all(10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.close_circle),
                  CustomSpacers.width10,
                  Text(
                    title,
                    style: AppTextThemes.lightTextTheme.headlineLarge,
                  ),
                ],
              ),
              onTap != null
                  ? GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset(AppIcons.edit),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          CustomSpacers.height4,
          child,
        ],
      ),
    );
  }
}
