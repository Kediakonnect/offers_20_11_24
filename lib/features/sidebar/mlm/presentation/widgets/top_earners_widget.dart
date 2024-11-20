import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';

class TopEarnersWidget extends StatelessWidget {
  const TopEarnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            textAlign: TextAlign.center,
            'Top Earners of Your District',
            style: Theme.of(context).textTheme.displayMedium),
        CustomSpacers.height20,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorPalette.primaryColor, width: 2),
          ),
          child: Column(
            children: [
              for (int i = 0; i < 3; i++) ...[
                _buildTextBlock(context),
                if (i != 2)
                  const Divider(
                    height: 10,
                    thickness: 1,
                    color: ColorPalette.primaryColor,
                  ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextBlock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dr Arvind Suradkar',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Congratulations on earning',
                  style: AppTextThemes.theme(context).bodyLarge,
                ),
                TextSpan(
                  text: ' 11,500 Coins ',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextSpan(
                  text: 'this week!',
                  style: AppTextThemes.theme(context).bodyLarge,
                ),
              ],
            ),
          ),
          Text(
            'User ID: MH28AB000011',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Taluka: Khamgaon',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
