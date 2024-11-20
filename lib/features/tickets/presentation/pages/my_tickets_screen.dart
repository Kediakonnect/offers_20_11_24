import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/tickets/presentation/widget/ticket_widget.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  final _filterTc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "MY TICKETS",
      enableMenu: true,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          CustomNavigator.pushTo(context, AppRouter.createTicketScreen);
        },
        label: "Open new Ticket",
        icon: Icons.add,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropDown(
              options: const ["Filter 1", "Filter 2"],
              controller: _filterTc,
              hintText: "Filter Tickets",
              height: 30.h,
              width: 150.w,
            ),
            CustomSpacers.height30,
            Column(
              children: [
                const TicketWidget(),
                CustomSpacers.height20,
                const TicketWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
