import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinAndEarnScreenTwo extends StatefulWidget {
  const JoinAndEarnScreenTwo({super.key});

  @override
  State<JoinAndEarnScreenTwo> createState() => _JoinAndEarnScreenTwoState();
}

class _JoinAndEarnScreenTwoState extends State<JoinAndEarnScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Join and Earn".toUpperCase(),
      enableBottomSheet: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSpacers.height120,
            CustomDropDown(
              options: const ['Option 1', 'Option 2'],
              controller: TextEditingController(),
              hintText: 'Select card',
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: 'Card number',
              controller: TextEditingController(),
            ),
            CustomSpacers.height20,
            const AttachOrReviewShopPicWidget(
              onlyPickSecondaryImages: true,
              maxSecondaryImages: 1,
              secondaryImageLabel: 'Image of the selected card',
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: 'Enter OTP',
              controller: TextEditingController(),
            ),
            CustomSpacers.height30,
            CustomButton(
              btnText: 'BECOME BUSINESS ASSOCIATE 4 FREE',
              onPressed: () {},
            ),
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
          ],
        ),
      ),
    );
  }
}
