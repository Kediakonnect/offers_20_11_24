import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/news_card.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CustomDropDown(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.39,
            options: const ["Location 1", "Location 2"],
            hintText: 'Location',
            controller: TextEditingController(),
          ),
        ),
        CustomSpacers.height20,
        _buildNewsGrid(context),
      ],
    );
  }

  Widget _buildNewsGrid(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        for (int i = 0; i < 5; i++)
          NewsCard(
            onTap: () =>
                CustomNavigator.pushTo(context, AppRouter.newsPaperScreen),
          ),
      ],
    );
  }
}
