import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/badge.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "MY TICKET",
      enableMenu: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This is my first ticket. I request admin to resolve the issue as soon as possible.",
              style: AppTextThemes.lightTextTheme.displayLarge,
            ),
            CustomSpacers.height10,
            const CustomBadge(
              text: "Closed",
              color: ColorPalette.textDark,
            ),
            CustomSpacers.height10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details:",
                  style: AppTextThemes.lightTextTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "I have already checked my account balance and verified the recipient details. Despite that, the transaction did not go through as expected. This is a matter of urgency, and I would appreciate prompt assistance in resolving this issue.\n\nThank you for your attention to this matter.",
                  style: AppTextThemes.lightTextTheme.bodyLarge,
                )
              ],
            ),
            CustomSpacers.height20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reply:",
                  style: AppTextThemes.lightTextTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Thank you for reaching out to [Payment App] Support. We apologize for any inconvenience you've experienced, and we're committed to resolving this matter promptly.\n\nOur technical team is currently investigating the issue you reported. In the meantime, please provide us with the following additional information to expedite the resolution process:\n\n1. Screenshots or a detailed description of any error messages received.\n2. The type of device you used for the transaction (e.g., smartphone, tablet, desktop).\n3. The operating system and version of the device.\n4. The version of the [Payment App] you have installed.\n\nOnce we receive this information, we will work diligently to identify and address the root cause of the problem. If necessary, we may reach out to you for further clarification.\n\nWe appreciate your patience and understanding as we work to resolve this issue. Rest assured that we are doing our best to ensure a quick and satisfactory resolution.\n\nIf you have any additional questions or concerns, feel free to reply to this email or contact our support team at [Support Contact Information].\n\nThank you for choosing [Payment App].\n\nBest regards,\n\n[Payment App] Support Team",
                  style: AppTextThemes.lightTextTheme.bodyLarge!.copyWith(
                    color: ColorPalette.textDark,
                  ),
                ),
              ],
            ),
            CustomSpacers.height30,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelValueWidget(
                  label: "Created on",
                  value: "23-09-2023",
                ),
                CustomSpacers.height10,
                const LabelValueWidget(
                  label: "Status",
                  value: "Closed",
                ),
              ],
            ),
            CustomSpacers.height30,
            Center(
              child: GoBackButton(
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
