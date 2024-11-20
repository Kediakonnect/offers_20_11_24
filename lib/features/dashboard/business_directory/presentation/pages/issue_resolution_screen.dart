import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/enums/business_status.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_status.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssuesResolutionScreen extends StatelessWidget {
  const IssuesResolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Issues Resolution'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
            Text(
              'Dhruv Super Bazar',
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height10,
            const BusinessStatusWidget(
              status: BusinessStatusType.suspended,
            ),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Action', value: 'Suspended'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Action TimeStamp', value: '01-01-2022'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Reason', value: 'Violation of privacy'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Actual Complaint',
                value: 'This business has shown my personal email as theirs'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Admin remark',
                value:
                    'This is a serious offence. Urgent action is required from your side to avoid any further action.'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'How to resolve',
                value:
                    'Consider editing to change content of the field in question so that it does not contain any objectionable content and submit.'),
            CustomSpacers.height21,
            _buildOulinedContainer(context),
            CustomSpacers.height21,
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFloatingActionButton(
                      onPressed: () => CustomNavigator.pushTo(
                          context, AppRouter.addNewBusiness,
                          arguments: BusinessFormType.edit),
                      label: 'Edit this business'),
                  CustomSpacers.width10,
                  CustomFloatingActionButton(
                      onPressed: () {}, label: 'Raise a ticket'),
                ],
              ),
            ),
            CustomSpacers.height56,
          ],
        ),
      ),
    );
  }

  Widget _buildOulinedContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        textAlign: TextAlign.center,
        style: AppTextThemes.theme(context).bodyLarge,
        "If you agree with the allegation in the report and/or the solution recommended by the admin, edit the relevant part and submit. We will verify the changes and restore the status if everything looks good.If you do not agree with the allegations and feel that you can explain your side, raise a ticket with appropriate title and explanation.",
      ),
    );
  }
}
