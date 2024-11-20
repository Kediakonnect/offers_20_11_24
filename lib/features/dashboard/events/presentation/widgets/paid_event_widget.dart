import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../ui/moleclues/nueromorphic_container.dart';

class PaidEventWidget extends StatelessWidget {
  const PaidEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTitle(context);
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(const BorderSide(
              color: ColorPalette.primaryColor,
              width: 1,
            )),
          ),
          onPressed: () {},
          child: Text(
            'PAID EVENT',
            style: AppTextThemes.theme(context)
                .headlineSmall
                ?.copyWith(color: ColorPalette.primaryColor, fontSize: 12.sp),
          ),
        ),
        CustomSpacers.width20,
        _buildIcon(icon: AppIcons.phone, onTap: () {}),
        CustomSpacers.width20,
        _buildIcon(icon: AppIcons.whatsAppColored, onTap: () {}),
      ],
    );
  }

  Widget _buildIcon({required String icon, required VoidCallback onTap}) {
    return NeuroMorphicContainer(
      padding: EdgeInsets.all(4.w),
      shape: BoxShape.circle,
      child: SvgPicture.asset(
        icon,
        height: 20,
        width: 20,
      ),
    );
  }
}
