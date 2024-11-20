import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/icon_text.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBonusScreen extends StatefulWidget {
  const MyBonusScreen({super.key});

  @override
  State<MyBonusScreen> createState() => _MyBonusScreenState();
}

class _MyBonusScreenState extends State<MyBonusScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'My Bonus'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          children: [
            CustomSpacers.height20,
            const LabelValueWidget(label: 'User ID', value: '12345'),
            Text(
              '(05 Nov - 12 Nov)',
              style: AppTextThemes.theme(context).bodySmall?.copyWith(
                    color: ColorPalette.grey,
                  ),
            ),
            CustomSpacers.height20,
            OutlinedContainer(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Personal as sales commission',
                    style: AppTextThemes.theme(context).bodyLarge,
                  ),
                  CustomSpacers.height12,
                  Center(
                      child:
                          IconText(assetName: AppIcons.diamond, text: '5,100')),
                ],
              ),
            ),
            CustomSpacers.height20,
            OutlinedContainer(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextRow(label: 'Total Business', value: '₹ 7,806'),
                  CustomSpacers.height10,
                  _buildTextRow(
                      label: 'Gross Bonus',
                      value: '₹ 7,806',
                      icon: AppIcons.diamond),
                  CustomSpacers.height10,
                  _buildTextRow(
                      label: 'Net Bonus',
                      value: '₹ 7,806',
                      icon: AppIcons.diamond),
                  CustomSpacers.height10,
                  Text(
                    'Net Bonus = Gross Bonus - Downline Bonus',
                    style: AppTextThemes.theme(context).bodySmall?.copyWith(
                          color: ColorPalette.grey,
                        ),
                  ),
                ],
              ),
            ),
            CustomSpacers.height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildImmediateContainer('Immediate Left'),
                _buildImmediateContainer('Immediate Right'),
              ],
            ),
            CustomSpacers.height20,
            Text(
              textAlign: TextAlign.center,
              'Bonus Awaits\nReach Targets, Celebrate Success!',
              style: AppTextThemes.theme(context).headlineLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImmediateContainer(String label) {
    return OutlinedContainer(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextThemes.theme(context).headlineLarge,
            ),
            CustomSpacers.height10,
            _buildTextRow(label: 'Business', value: '₹ 7,806'),
            CustomSpacers.height10,
            _buildTextRow(label: 'Bonus', value: '806', icon: AppIcons.diamond),
          ],
        ));
  }

  Widget _buildTextRow(
      {required String label, required String value, String? icon}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            '$label  ',
            style: AppTextThemes.theme(context).bodyLarge,
          ),
          if (icon == null)
            Text(
              value,
              style: AppTextThemes.theme(context).headlineLarge,
            ),
          if (icon != null)
            IconText(
              assetName: icon,
              text: value,
              style: AppTextThemes.theme(context).headlineLarge,
            ),
        ],
      ),
    );
  }
}
