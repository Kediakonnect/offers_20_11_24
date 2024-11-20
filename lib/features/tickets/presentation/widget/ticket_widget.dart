import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/badge.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.pushTo(context, AppRouter.ticketsScreen);
      },
      child: NeuroMorphicContainer(
        borderRadius: 10,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBadge(
              text: "Open",
              color: ColorPalette.green,
            ),
            CustomSpacers.height10,
            Text(
              "This is second ticket. I hereby request the admin to resolve the issue.",
              style: AppTextThemes.lightTextTheme.headlineLarge,
            ),
            CustomSpacers.height8,
            Text(
              "Last update: 18-12-2023 09:15 AM",
              style: AppTextThemes.lightTextTheme.bodySmall!.copyWith(
                color: ColorPalette.textPlaceholder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
