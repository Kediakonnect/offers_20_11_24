import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/utils/enums.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAnnoucementScreen extends StatelessWidget {
  final AddAnnoucementFormType addAnnoucementFormType;
  const AddAnnoucementScreen({super.key, required this.addAnnoucementFormType});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: addAnnoucementFormType.title,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          children: [
            CustomSpacers.height120,
            CustomTextField(
              hintText: 'Announcement title',
              controller: TextEditingController(),
            ),
            CustomSpacers.height20,
            CustomTextField(
              hintText: 'Announcement description',
              controller: TextEditingController(),
              maxLines: 5,
            ),
            CustomSpacers.height20,
            const AttachOrReviewShopPicWidget(
              maxSecondaryImages: 1,
              onlyPickSecondaryImages: true,
              secondaryImageLabel: 'Announcement image',
            ),
            CustomSpacers.height20,
            CustomButton(onPressed: () {}, btnText: 'Submit')
          ],
        ),
      ),
    );
  }
}
