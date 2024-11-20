import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/gst_calculator_type.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class GSTCalculator extends StatefulWidget {
  final GSTCalculatorType gstCalculatorType;
  const GSTCalculator({super.key, required this.gstCalculatorType});

  @override
  State<GSTCalculator> createState() => _GSTCalculatorState();
}

class _GSTCalculatorState extends State<GSTCalculator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: widget.gstCalculatorType.getHintText,
          controller: TextEditingController(),
        ),
        CustomSpacers.height30,
        CustomButton(onPressed: () {}, btnText: 'Next'),
        CustomSpacers.height30,
        Text(
          '100 ${widget.gstCalculatorType.isDiamondsToCoins ? 'Diamonds' : 'Coins'} = 100 ₹',
          style: AppTextThemes.theme(context).headlineLarge,
        ),
        CustomSpacers.height30,
        _buildCalculator(),
        CustomSpacers.height30,
        CustomCheckBoxTile(
            onChanged: (v) {}, option: 'I want invoice with GST'),
        CustomSpacers.height30,
        CustomTextField(
            hintText: 'Enter GST number', controller: TextEditingController()),
        CustomSpacers.height30,
        CustomTextField(
          hintText: 'Confirm GST number',
          controller: TextEditingController(),
        ),
        CustomSpacers.height30,
        CustomButton(
          onPressed: () {},
          btnText: widget.gstCalculatorType.getBtnText,
        ),
      ],
    );
  }

  Widget _buildCalculator() {
    return Column(
      children: [
        _buildRowOfCal(
            title: widget.gstCalculatorType.calculatorText, value: '100'),
        _buildRowOfCal(title: '18% GST', value: '16'),
        const Divider(
          thickness: 2,
          color: ColorPalette.textDark,
        ),
        _buildRowOfCal(title: 'Total', value: '100'),
      ],
    );
  }

  Widget _buildRowOfCal({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.58,
          child: Text(
            textAlign: TextAlign.end,
            title,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            value,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ),
      ],
    );
  }
}
