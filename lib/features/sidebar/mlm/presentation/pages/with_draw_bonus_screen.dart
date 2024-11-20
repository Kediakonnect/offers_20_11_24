import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/mini_state_ment_widget.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/icon_text.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithDrawBonusScreen extends StatefulWidget {
  const WithDrawBonusScreen({super.key});

  @override
  State<WithDrawBonusScreen> createState() => _WithDrawBonusScreenState();
}

class _WithDrawBonusScreenState extends State<WithDrawBonusScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'WithDraw Bonus'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
            _buildContainerOne(),
            CustomSpacers.height20,
            const MiniStatementWidget(),
            CustomSpacers.height20,
            _getStatementWidget(),
            CustomSpacers.height20,
            _buildBankDetails(),
            CustomSpacers.height20,
            _buildWithdrawAmount(),
            CustomSpacers.height40,
          ],
        ),
      ),
    );
  }

  Widget _getStatementWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Get account statement',
              style: AppTextThemes.theme(context).bodyLarge,
            ),
          ),
          CustomSpacers.height20,
          CustomTextField(
              hintText: 'From', controller: TextEditingController()),
          CustomSpacers.height20,
          CustomTextField(hintText: 'To', controller: TextEditingController()),
          CustomSpacers.height30,
          CustomButton(
            onPressed: () {},
            btnText: 'Email Statement',
          ),
          CustomSpacers.height30,
          const NeuroMorphicText(
            text: 'Convert Into coins',
            color: ColorPalette.yellow,
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawAmount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
              hintText: 'Withdrawal amount',
              controller: TextEditingController()),
          CustomSpacers.height20,
          CustomButton(
            onPressed: () {},
            btnText: 'Get OTP',
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetails() {
    TextStyle? valueStyle = AppTextThemes.theme(context).bodyLarge;
    TextStyle? labelStyle = AppTextThemes.theme(context)
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.w600);
    return OutlinedContainer(
      padding: EdgeInsets.all(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Bank Account Name',
                style: valueStyle,
              ),
              CustomSpacers.height10,
              Text(
                'Account Number',
                style: valueStyle,
              ),
              CustomSpacers.height10,
              Text(
                'IFS Code',
                style: valueStyle,
              ),
            ],
          ),
          CustomSpacers.width10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yashodhan Bhale',
                style: labelStyle,
              ),
              CustomSpacers.height10,
              Text(
                '31969292729',
                style: labelStyle,
              ),
              CustomSpacers.height10,
              Text(
                'SBIN0003282',
                style: labelStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainerOne() {
    return OutlinedContainer(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Text(
            'Last Bonus Breakup',
            style: AppTextThemes.theme(context).headlineLarge,
          ),
          CustomSpacers.height10,
          const Text(
            'Credit Date : 06-11-2023',
          ),
          CustomSpacers.height10,
          const Text(
            'Eligibility Level : 2',
          ),
          CustomSpacers.height10,
          _buildLableText(label: 'Gross Bonus', value: '2,500'),
          CustomSpacers.height10,
          _buildLableText(label: 'Gross Bonus', value: '2,500'),
          CustomSpacers.height10,
          Row(
            children: [
              _buildLableText(label: 'Left Bonus', value: '2,500'),
              const Spacer(),
              _buildLableText(label: 'Right Bonus', value: '2,500'),
            ],
          ),
          CustomSpacers.height10,
          _buildLableText(label: 'Net Bonus', value: '2,500'),
        ],
      ),
    );
  }

  Widget _buildLableText({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$label : ', style: AppTextThemes.theme(context).bodyLarge),
        IconText(assetName: AppIcons.diamond, text: value),
      ],
    );
  }
}
