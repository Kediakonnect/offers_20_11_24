import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/notification/presentation/widgets/notification_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "NOTIFICATION",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            CustomTabWidget(
              onValueChange: (v) {},
              options: const {"ADMIN", "MLM", "B2B", "OTHER"},
              optionWidth: 64.w,
              borderRadius: 10.r,
            ),
            CustomSpacers.height20,
            const NotificationWidget(
              date: "08:34 AM, 18 DEC 2023",
              title:
                  "Your offer titled “50% off on select brands” has been approved.",
            ),
            CustomSpacers.height20,
            const NotificationWidget(
              date: "08:34 AM, 18 DEC 2023",
              title:
                  "Your offer titled “50% off on select brands” has been approved.",
            ),
            CustomSpacers.height20,
            NotificationWidget(
              date: "08:34 AM, 18 DEC 2023",
              title:
                  "Your offer titled “50% off on select brands” has been approved.",
              imageUrl: AppImages.dailyPrize,
            ),
          ],
        ),
      ),
    );
  }
}
