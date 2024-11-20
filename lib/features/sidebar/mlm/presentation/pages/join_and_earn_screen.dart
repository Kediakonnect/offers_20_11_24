import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/widgets/top_earners_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinAndEarnScreen extends StatelessWidget {
  const JoinAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Join and Earn".toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSpacers.height20,
            Text(
              textAlign: TextAlign.center,
              'Total Downline Members Under You',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            CustomSpacers.height6,
            Text(
              textAlign: TextAlign.center,
              '328',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 20.sp),
            ),
            CustomSpacers.height20,
            const TopEarnersWidget(),
            CustomSpacers.height20,
            const TopEarnersWidget(),
            CustomSpacers.height20,
            const TopEarnersWidget(),
          ],
        ),
      ),
    );
  }
}
