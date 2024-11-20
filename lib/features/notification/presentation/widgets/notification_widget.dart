import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  final String date;
  final String title;
  final String? imageUrl;

  const NotificationWidget({
    super.key,
    required this.date,
    required this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: AppTextThemes.lightTextTheme.bodySmall!.copyWith(
            color: ColorPalette.textPlaceholder,
          ),
        ),
        CustomSpacers.height4,
        Text(
          title,
          style: AppTextThemes.lightTextTheme.bodyLarge!.copyWith(
            color: imageUrl == null ? null : ColorPalette.primaryColor,
            fontWeight: imageUrl != null ? FontWeight.bold : null,
          ),
        ),
        CustomSpacers.height4,
        if (imageUrl != null)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This is a title of an offer which should fit in a single line",
                      style: AppTextThemes.lightTextTheme.bodyLarge!.copyWith(),
                    ),
                    CustomSpacers.height4,
                    const LabelValueWidget(
                      label: "Category",
                      value: "Footwear",
                    ),
                    CustomSpacers.height4,
                    const LabelValueWidget(
                      label: "Offer Price",
                      value: "500",
                    ),
                  ],
                ),
              ),
              CustomSpacers.width10,
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
      ],
    );
  }
}
