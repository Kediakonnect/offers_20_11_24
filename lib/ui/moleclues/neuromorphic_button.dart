import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/atoms/bouncing_widget.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuromorphicButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final double? height, width;
  const NeuromorphicButton(
      {super.key,
      required this.btnText,
      this.height,
      this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onPressed,
      child: NeuroMorphicContainer(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
        child: Text(
          btnText,
          style: AppTextThemes.theme(context).titleLarge,
        ),
      ),
    );
  }
}
