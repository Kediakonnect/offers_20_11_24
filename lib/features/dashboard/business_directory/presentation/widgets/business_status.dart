import 'package:divyam_flutter/core/enums/business_status.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessStatusWidget extends StatelessWidget {
  final BusinessStatusType status;
  const BusinessStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: status.color,
      ),
      child: Text(
        status.name,
        style: AppTextThemes.theme(context)
            .bodySmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
