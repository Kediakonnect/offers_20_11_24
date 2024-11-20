import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/news_viewer_card.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPaperScreen extends StatefulWidget {
  const NewsPaperScreen({super.key});

  @override
  State<NewsPaperScreen> createState() => _NewsPaperScreenState();
}

class _NewsPaperScreenState extends State<NewsPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'NewsPaper'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
            Text('Times of India',
                style: Theme.of(context).textTheme.displayLarge),
            CustomSpacers.height20,
            const LabelValueWidget(label: 'Issue date', value: '13-12-2023'),
            CustomSpacers.height20,
            Align(
              alignment: Alignment.center,
              child: NewsViewerCard(
                onTap: onNewsTap,
                pageNo: 'Front page',
                height: 270,
                width: 240,
              ),
            ),
            CustomSpacers.height20,
            Align(
              alignment: Alignment.center,
              child: NewsViewerCard(
                onTap: onNewsTap,
                pageNo: 'Page 2',
                height: 270,
                width: 240,
              ),
            ),
            CustomSpacers.height120,
          ],
        ),
      ),
    );
  }

  void onNewsTap() {
    CustomNavigator.pushTo(context, AppRouter.newsDetailScreen);
  }
}
