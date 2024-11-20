import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "TERMS & CONDITIONS",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Terms & Conditions",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
            Text(
              "Sellar Terms & Conditions",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
            Text(
              "Publisher Terms & Conditions",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
            Text(
              "MLM Associate Terms & Conditions",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
            Text(
              "Privacy Policy",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
            Text(
              "Copyright Information",
              style: AppTextThemes.lightTextTheme.headlineLarge!.copyWith(
                color: ColorPalette.primaryColor,
              ),
            ),
            CustomSpacers.height20,
          ],
        ),
      ),
    );
  }
}
