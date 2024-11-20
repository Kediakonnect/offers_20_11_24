import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyTeamWidget extends StatelessWidget {
  const MyTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
        padding: EdgeInsets.all(20.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Team',
                    style: AppTextThemes.theme(context).headlineLarge),
                CustomSpacers.height10,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const CustomTable(
                    borderRadius: 0,
                    borderThickness: 1,
                    bordercolor: ColorPalette.grey,
                    headers: ['B.A', 'Total'],
                    rows: [
                      ['10', '20'],
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSpacers.height30,
                SvgPicture.asset(
                  height: 41.h,
                  width: 41.w,
                  AppIcons.graph,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Team',
                    style: AppTextThemes.theme(context).headlineLarge),
                CustomSpacers.height10,
                Text('This week',
                    style: AppTextThemes.theme(context).bodyMedium),
                CustomSpacers.height10,
                Text('12 / 55', style: AppTextThemes.theme(context).bodyMedium),
                CustomSpacers.height10,
              ],
            ),
          ],
        ));
  }
}
