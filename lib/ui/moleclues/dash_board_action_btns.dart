import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashBoardActionButtons extends StatelessWidget {
  final VoidCallback? onAddPressed, onMlmPressed;
  final bool disabledMlm, disabledAdd;
  const DashBoardActionButtons(
      {super.key,
      this.onAddPressed,
      this.onMlmPressed,
      this.disabledMlm = false,
      this.disabledAdd = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: !disabledAdd,
            child: SizedBox(
              height: 40.h,
              width: 40.h,
              child: FloatingActionButton(
                heroTag: 'btn1',
                shape: const CircleBorder(),
                onPressed: onAddPressed,
                elevation: 0, // No shadow
                highlightElevation: 0, // No shadow when pressed
                backgroundColor: ColorPalette.primaryColor.withOpacity(.5),
                child: const Icon(
                  Icons.add,
                  color: ColorPalette.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          CustomSpacers.height16,
          Visibility(
            visible: !disabledMlm,
            child: SizedBox(
              height: 40.h,
              width: 40.h,
              child: FloatingActionButton(
                heroTag: 'btn2',
                shape: const CircleBorder(),
                onPressed: onMlmPressed,
                elevation: 0, // No shadow
                highlightElevation: 0, // No shadow when pressed
                backgroundColor: ColorPalette.primaryColor.withOpacity(.5),
                child: SvgPicture.asset(
                  AppIcons.mlm,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ),
          CustomSpacers.height16,
        ],
      ),
    );
  }
}
