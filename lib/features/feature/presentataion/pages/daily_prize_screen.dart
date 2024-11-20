import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/profile_picture_selector.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyPrizeScreen extends StatefulWidget {
  const DailyPrizeScreen({super.key});

  @override
  State<DailyPrizeScreen> createState() => _DailyPrizeScreenState();
}

class _DailyPrizeScreenState extends State<DailyPrizeScreen> {
  final _locationTc = TextEditingController();
  final _numberOrTextTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "DAILY PRIZE",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomDropDown(
              options: const ["Khamgaon", "Banglore"],
              controller: _locationTc,
              height: 30.h,
              hintText: "Location",
              width: 150.w,
            ),
            CustomSpacers.height20,
            DailyPrizeFormWidget(numberOrTextTc: _numberOrTextTc),
            CustomSpacers.height20,
            const DailyPrizeWinners(),
            CustomSpacers.height20,
            NeuroMorphicContainer(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
                vertical: 20.h,
              ),
              width: double.infinity,
              borderRadius: 10.r,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorPalette.primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "Previous Winner",
                      style:
                          AppTextThemes.lightTextTheme.headlineSmall!.copyWith(
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                  CustomSpacers.height10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _previousWinnerRow("E. Johnson", "E. Johnson"),
                      _previousWinnerRow("E. Johnson", "E. Johnson"),
                      _previousWinnerRow("E. Johnson", "E. Johnson"),
                      _previousWinnerRow("E. Johnson", "E. Johnson"),
                      _previousWinnerRow("E. Johnson", "E. Johnson"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _previousWinnerRow(String rowOneName, String rowTwoName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rowOneName,
          style: AppTextThemes.lightTextTheme.bodyLarge,
        ),
        CustomSpacers.width20,
        Text(
          rowTwoName,
          style: AppTextThemes.lightTextTheme.bodyLarge,
        ),
      ],
    );
  }
}

class DailyPrizeWinners extends StatelessWidget {
  const DailyPrizeWinners({
    super.key,
  });

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
              "Last Winners - 25 DEC",
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                AppImages.feature,
                width: double.infinity,
                height: 160.h,
                fit: BoxFit
                    .cover, // Optional: To make sure the image covers the entire container
              ),
            ),
          ),
          CustomSpacers.height10,
          Text(
            "Dr Arvind Suradkar",
            style: AppTextThemes.lightTextTheme.headlineLarge,
          ),
          CustomSpacers.height4,
          Text(
            "8149747752",
            style: AppTextThemes.lightTextTheme.bodyLarge,
          ),
          CustomSpacers.height20,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                AppImages.feature,
                width: double.infinity,
                height: 160.h,
                fit: BoxFit
                    .cover, // Optional: To make sure the image covers the entire container
              ),
            ),
          ),
          CustomSpacers.height10,
          Text(
            "Dr Arvind Suradkar",
            style: AppTextThemes.lightTextTheme.headlineLarge,
          ),
          CustomSpacers.height4,
          Text(
            "8149747752",
            style: AppTextThemes.lightTextTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class DailyPrizeFormWidget extends StatelessWidget {
  const DailyPrizeFormWidget({
    super.key,
    required TextEditingController numberOrTextTc,
  }) : _numberOrTextTc = numberOrTextTc;

  final TextEditingController _numberOrTextTc;

  @override
  Widget build(BuildContext context) {
    return NeuroMorphicContainer(
      borderRadius: 10.r,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 30.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "10 Nov",
              textAlign: TextAlign.end,
              style: AppTextThemes.lightTextTheme.bodyLarge,
            ),
          ),
          CustomSpacers.height6,
          Text(
            "Get offer postings of value more than ₹ 1000",
            style: AppTextThemes.lightTextTheme.headlineLarge,
          ),
          CustomSpacers.height10,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Image.network(
              AppImages.dailyPrize,
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
            ),
          ),
          CustomSpacers.height20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Number / Text",
                  controller: _numberOrTextTc,
                ),
                CustomSpacers.height20,
                const ProfilePicViewerOrSelectorWidget(
                  label: "Attach Image",
                  changeImageText: "Change Image",
                ),
                CustomSpacers.height20,
                CustomButton(
                  btnText: "Submit",
                  onPressed: () {},
                  width: double.infinity,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
