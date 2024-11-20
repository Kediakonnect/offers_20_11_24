import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/around_me_tab.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/famous_tab.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/news_tab.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:divyam_flutter/ui/moleclues/dash_board_action_btns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<HighlightsScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'Highlights'.toUpperCase(),
      floatingActionButton: DashBoardActionButtons(
        disabledAdd: _currentIndex == 0,
        onAddPressed: () =>
            CustomNavigator.pushTo(context, AppRouter.myAnnoucementScreen),
        onMlmPressed: () {
          CustomNavigator.pushTo(context, AppRouter.myNewsScreen);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomSpacers.height20,
            CustomTabWidget(
              borderRadius: 5,
              onValueChange: (v) {
                setState(() {
                  _currentIndex = v;
                });
              },
              options: {
                'News'.toUpperCase(),
                'Famous'.toUpperCase(),
                'Around me'.toUpperCase()
              },
              optionWidth: 100,
            ),
            CustomSpacers.height20,
            _buildTabWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabWidgets() {
    switch (_currentIndex) {
      case 0:
        return const NewsTab();
      case 1:
        return const FamousTab();
      case 2:
        return AroundMeTab();
      default:
        return const NewsTab();
    }
  }
}
