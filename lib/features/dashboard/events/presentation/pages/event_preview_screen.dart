import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/event_card.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPreviewScreen extends StatelessWidget {
  const EventPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Add New Event'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomSpacers.height20,
            Text(
              'Preview',
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height30,
            EventCard(
              onTap: () {},
            ),
            CustomSpacers.height30,
            CustomButton(onPressed: () {}, btnText: 'Confirm'),
            CustomSpacers.height56,
          ],
        ),
      ),
    );
  }
}
