import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/suspended_box.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/widgets/my_news_table.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyNewsDetailScreen extends StatelessWidget {
  const MyNewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My News'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height10,
            SuspendedBox(
              message:
                  'This newspaper has been suspended because of reported violation terms & conditions',
              onDetailTap: () {},
            ),
            CustomSpacers.height20,
            Text(
              'Times of India',
              style: AppTextThemes.theme(context).displayMedium,
            ),
            CustomSpacers.height20,
            const LabelValueWidget(
              label: 'State',
              value: 'Maharashtra',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'District / Metro city',
              value: 'Mumbai',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Registered address',
              value:
                  '1, 136, Dr E Moses Rd, Gandhi Nagar, Upper Worli, Worli, Mumbai, Maharashtra 400018, India',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Registered mobile',
              value: '+91 9028299771',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Registered email',
              value: 'r.yashodhan@gmail.com',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Authorized uploader user ID',
              value: 'MH01AS0001',
            ),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Authorized uploader mobile',
              value: '9028299771',
            ),
            CustomSpacers.height20,
            const MyNewsTable(
              headers: ['Date', 'Title', 'Description'],
              rows: [
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
                ['10/11/2021', '', ''],
              ],
            ),
            CustomSpacers.height120,
          ],
        ),
      ),
    );
  }
}
