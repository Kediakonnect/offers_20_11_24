import 'package:divyam_flutter/core/enums/offer_status.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/news_card.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';

class MyNewsScreen extends StatelessWidget {
  const MyNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My Newspapers'.toUpperCase(),
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.add,
        onPressed: () =>
            CustomNavigator.pushTo(context, AppRouter.addNewsPaperScreen),
        label: 'Add Newspaper',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSpacers.height20,
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                OfferStatusType.values.length,
                (index) => NewsCard(
                  onTap: () => CustomNavigator.pushTo(
                      context, AppRouter.myNewsPaperDetailScreen),
                  color: OfferStatusType.values[index].color,
                  label: OfferStatusType.values[index].name,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
