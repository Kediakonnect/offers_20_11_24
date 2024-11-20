import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberWidget extends StatelessWidget {
  final String number;
  const NumberWidget({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          number.length, (index) => _buildNumberText(number[index])),
    );
  }

  _buildNumberText(String number) {
    return Container(
      // height: 16.h,
      width: 18.h,
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      color: ColorPalette.textDark,
      child: Text(
        number,
        style: const TextStyle(
          color: ColorPalette.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
