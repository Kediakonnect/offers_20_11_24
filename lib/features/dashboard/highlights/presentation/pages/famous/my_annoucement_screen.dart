import 'package:divyam_flutter/core/enums/offer_status.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/utils/enums.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/annoucement_tile.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAnnoucementScreen extends StatelessWidget {
  const MyAnnoucementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: CustomFloatingActionButton(
          onPressed: () => CustomNavigator.pushTo(
                context,
                AppRouter.addAnnoucementScreen,
                arguments: AddAnnoucementFormType.create,
              ),
          label: 'Add New Announcement',
          icon: Icons.add),
      appBarTitle: 'My Annoucement'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomSpacers.height20,
            CustomTabWidget(
              tabWidth: 280,
              onValueChange: (val) {},
              options: const {'Active', 'Previous'},
              optionWidth: 129,
            ),
            CustomSpacers.height20,
            for (var offer in OfferStatusType.values) ...[
              AnnoucementTile(
                status: offer,
                onTap: () => CustomNavigator.pushTo(
                    context, AppRouter.myAnnoucementDetailScreen),
              ),
              CustomSpacers.height20,
            ]
          ],
        ),
      ),
    );
  }
}
