import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/gst_calculator_type.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/gst_calculator.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiamondCoinScreen extends StatelessWidget {
  final GSTCalculatorType gstCalculatorType;
  const DiamondCoinScreen({super.key, required this.gstCalculatorType});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: gstCalculatorType.title.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: FigmaValueConstants.defaultPaddingH.w,
        ),
        child: Column(
          children: [
            CustomSpacers.height16,
            Visibility(
              visible: gstCalculatorType == GSTCalculatorType.diamondsToCoins,
              child: Column(
                children: [
                  Text(
                    'Available Bonus Diamonds',
                    style: AppTextThemes.theme(context).headlineLarge,
                  ),
                  CustomSpacers.height20,
                  Text('1500',
                      style: AppTextThemes.theme(context).displayLarge),
                  CustomSpacers.height30,
                ],
              ),
            ),
            const LabelValueWidget(
              label: 'Note',
              value:
                  "\nRecharge Coins will be non-refundable Recharge Coins can only be used to post offers\n18% GST will be deducted",
            ),
            CustomSpacers.height30,
            GSTCalculator(
              gstCalculatorType: gstCalculatorType,
            ),
            CustomSpacers.height30,
            GoBackButton(
              onTap: () {
                CustomNavigator.pop(context);
              },
            ),
            CustomSpacers.height30,
          ],
        ),
      ),
    );
  }
}
