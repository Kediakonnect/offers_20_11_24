import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/feature/presentataion/widgets/feature_card_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewFeatureScreen extends StatefulWidget {
  const NewFeatureScreen({super.key});

  @override
  State<NewFeatureScreen> createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends State<NewFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "NEW FEATURES",
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            const FeatureCardWidget(),
            CustomSpacers.height20,
            const FeatureCardWidget(),
          ],
        ),
      ),
    );
  }
}
