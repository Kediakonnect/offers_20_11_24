import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/utils/enums.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/my_team_widget.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InviteAndEarnScreen extends StatelessWidget {
  const InviteAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: "Invite and Earn".toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w,
        ),
        child: Column(
          children: [
            CustomSpacers.height20,
            _buildButtons(context),
            CustomSpacers.height20,
            const MyTeamWidget(),
            CustomSpacers.height20,
            OutlinedContainer(
              padding: EdgeInsets.all(20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTextColumn(
                    heading: 'Left Team Business',
                    subHeading: '₹ 22,502',
                    context: context,
                  ),
                  _buildTextColumn(
                    heading: 'Total Business',
                    subHeading: '₹ 36,230',
                    context: context,
                  ),
                  _buildTextColumn(
                    heading: 'Right Team Business',
                    subHeading: '₹ 22,502',
                    context: context,
                  ),
                ],
              ),
            ),
            CustomSpacers.height20,
            OutlinedContainer(
              padding: EdgeInsets.all(20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'My Bonus',
                        style: AppTextThemes.theme(context).headlineLarge,
                      ),
                      CustomSpacers.height10,
                      IconText(
                        assetName: AppIcons.diamond,
                        text: '4,864',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        height: 41.h,
                        width: 41.w,
                        AppIcons.graph,
                      ),
                      CustomSpacers.width20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expected',
                              style:
                                  AppTextThemes.theme(context).headlineLarge),
                          CustomSpacers.height10,
                          Text('This week',
                              style: AppTextThemes.theme(context).bodyMedium),
                          CustomSpacers.height10,
                          IconText(
                            assetName: AppIcons.diamond,
                            text: '6,373',
                          ),
                          CustomSpacers.height10,
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            CustomSpacers.height20,
            _buildButtonGrid(InviteAndEarnBtns.values),
            CustomSpacers.height120,
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGrid(List<InviteAndEarnBtns> btns) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: btns.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 130 / 50, // Width / Height
      ),
      itemBuilder: (context, index) {
        return CustomButton(
          backgroundColor: ColorPalette.scaffoldBackgroundColor,
          textColor: ColorPalette.primaryColor,
          width: 130,
          height: 50,
          onPressed: () {},
          btnText: btns[index].label,
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSquareButton(btnText: 'To your left hand'),
        Text(
          textAlign: TextAlign.center,
          'invite\nfriends',
          style: AppTextThemes.theme(context).displayMedium,
        ),
        _buildSquareButton(btnText: 'To your right hand'),
      ],
    );
  }

  Widget _buildTextColumn(
      {required String heading,
      required String subHeading,
      required BuildContext context}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            heading,
            style: AppTextThemes.theme(context).headlineLarge,
          ),
          CustomSpacers.height10,
          Text(
            textAlign: TextAlign.center,
            subHeading,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton({required String btnText}) {
    return CustomButton(
      onPressed: () {},
      btnText: btnText,
      height: 95,
      width: 95,
    );
  }
}
