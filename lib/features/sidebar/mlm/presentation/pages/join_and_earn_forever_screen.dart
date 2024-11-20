import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_table.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class JoinAndEarnForeverScreen extends StatelessWidget {
  const JoinAndEarnForeverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'Join and Earn Forever'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          children: [
            CustomSpacers.height20,
            Text(
              textAlign: TextAlign.center,
              'Welcome to the most innovative and exciting MLM you have ever seen!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            CustomSpacers.height6,
            _buildIconText('Free joining for lifetime!', context),
            CustomSpacers.height10,
            _buildIconText('Referral ration 2:1 (Left & Right side)', context),
            CustomSpacers.height10,
            _buildIconText(
                'Get paid only for offer views and referrals on first 2 levels',
                context),
            CustomSpacers.height10,
            _buildIconText(
                'Earn network sales bonus from level 3 onwards as per table below',
                context),
            CustomSpacers.height20,
            CustomTable(
              headers: header,
              rows: rows,
            ),
            CustomSpacers.height10,
            _buildIconText(
                'Up to 20% additional commission on self offer referrals',
                context),
            CustomSpacers.height10,
            _buildIconText('10% special bonus for top achievers', context),
            CustomSpacers.height30,
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Terms & Conditions',
                  style: AppTextThemes.theme(context).titleLarge?.copyWith(
                        color: ColorPalette.primaryColor,
                      ),
                ),
              ),
            ),
            CustomSpacers.height30,
            const NeuroMorphicText(
              text: 'Watch Explanation Video',
              fontSize: 16,
            ),
            CustomSpacers.height30,
            CustomButton(
              onPressed: () {},
              btnText: 'Next',
            ),
            CustomSpacers.height160,
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(String text, BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.stars,
        ),
        CustomSpacers.width10,
        Expanded(
            child: Text(
          text,
          style: AppTextThemes.theme(context).bodyMedium,
        )),
      ],
    );
  }
}

// sample data for testing
List<String> header = [
  "Pairs",
  "Bonus",
  "Likes",
  "Sales",
];

List<List<String>> rows = [
  ["9", "5%", "250", "₹ 0"],
  ["90", "10%", "500", "₹ 0"],
  ["900", "15%", "750", "₹ 5,00"],
  ["4,500", "18%", "1,000", "₹ 1,000"],
  ["9,000", "21%", "1,250", "₹ 2,000"],
  ["45,000", "24%", "1,500", "₹ 3,000"],
  ["90,000", "27%", "2,000", "₹ 4,000"],
  ["4,50,000", "30%", "2,250", "₹ 5,000"],
  ["9 Lakh", "32%", "2,500", "₹ 6,000"],
  ["45 Lakh", "34%", "2,750", "₹ 7,000"],
  ["90 Lakh", "36%", "3,000", "₹ 8,000"],
  ["450 Lakh", "38%", "3,250", "₹ 9,000"],
  ["900 Lakh", "39%", "3,500", "₹ 10,000"],
  ["Above 900 Lakh", "40%", "3,500", "₹ 10,000"],
];
