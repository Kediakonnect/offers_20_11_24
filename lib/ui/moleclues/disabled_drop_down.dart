import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisabledDropDown extends StatelessWidget {
  final double? height, width;
  final String? hintText;
  final VoidCallback onTap;
  const DisabledDropDown({
    super.key,
    this.height = 32,
    required this.onTap,
    this.width = 150,
    this.hintText = "Select an option",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuroMorphicContainer(
        height: height!.h,
        width: width!.w,
        borderRadius: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          children: [
            Text(
              hintText!,
              style: AppTextThemes.theme(context).titleLarge?.copyWith(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down,
              color: ColorPalette.textDark,
            ),
          ],
        ),
      ),
    );
  }
}
