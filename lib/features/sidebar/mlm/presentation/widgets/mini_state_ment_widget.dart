import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/outlined_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniStatementWidget extends StatelessWidget {
  const MiniStatementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Mini Statement',
            style: AppTextThemes.theme(context).headlineLarge,
          ),
          CustomSpacers.height10,
          _buildTextRow(
            date: "26/10/2023",
            amount: "2103.00",
            status: "Bonus for week",
            context: context,
          ),
          CustomSpacers.height10,
          _buildTextRow(
            date: "26/10/2023",
            amount: "2103.00",
            status: "Bonus for week",
            context: context,
          ),
          CustomSpacers.height10,
          _buildTextRow(
            date: "26/10/2023",
            amount: "0.00",
            status: "Bonus for week",
            context: context,
          ),
          CustomSpacers.height10,
          _buildTextRow(
            date: "26/10/2023",
            amount: "2103.00 DB",
            status: "Bonus Withdrawal",
            color: ColorPalette.blue,
            context: context,
          ),
          CustomSpacers.height10,
          _buildTextRow(
            date: "26/10/2023",
            amount: "0.00",
            status: "Bonus for week",
            context: context,
          ),
          CustomSpacers.height30,
          Row(
            children: [
              Text(
                'Available Balance',
                style: AppTextThemes.theme(context).bodyMedium,
              ),
              CustomSpacers.width10,
              Text(
                '2103.00',
                style: AppTextThemes.theme(context).bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextRow({
    required String date,
    required String amount,
    required String status,
    required BuildContext context,
    Color? color = ColorPalette.green,
  }) {
    final textStyle = AppTextThemes.theme(context).bodyMedium;

    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            date,
            style: textStyle?.copyWith(color: color),
          ),
          CustomSpacers.width20,
          Row(
            children: [
              Text(
                amount,
                style: textStyle?.copyWith(color: color),
              ),
              CustomSpacers.width10,
              Text(
                status,
                style: textStyle?.copyWith(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
