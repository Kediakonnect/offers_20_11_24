import 'package:divyam_flutter/core/enums/event_form_type.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/event_card.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: CustomFloatingActionButton(
          onPressed: () => CustomNavigator.pushTo(
                context,
                AppRouter.myEventForm,
                arguments: EventFormType.create,
              ),
          label: 'Add New Event',
          icon: Icons.add),
      appBarTitle: 'My events'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomSpacers.height30,
            CustomTabWidget(
              tabWidth: 280,
              onValueChange: (val) {},
              options: const {'Active', 'Previous'},
              optionWidth: 129,
            ),
            CustomSpacers.height20,
            for (int i = 0; i < 5; i++) ...[
              EventCard(
                onTap: () => CustomNavigator.pushTo(
                    context, AppRouter.eventDetailScreenTwo),
                type: EventCardType.secandory,
              ),
              CustomSpacers.height20,
            ]
          ],
        ),
      ),
    );
  }
}
