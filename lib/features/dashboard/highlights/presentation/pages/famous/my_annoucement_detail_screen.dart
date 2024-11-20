import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/suspended_box.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/utils/enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_chip.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAnnoucementDetailScreen extends StatelessWidget {
  const MyAnnoucementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My Annoucement'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
            SuspendedBox(
              message:
                  'This announcement has been rejected because of reported violation of privacy',
              onDetailTap: () => CustomNavigator.pushTo(
                  context, AppRouter.issuesResolutionScreen),
            ),
            CustomSpacers.height20,
            Text(
              'Happy Birthday Amit',
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height10,
            const CustomChip(color: ColorPalette.red, text: 'Rejected'),
            CustomSpacers.height10,
            const LabelValueWidget(
              label: 'Description',
              value: 'Wish you a very happy birthday @%&**&^#!',
            ),
            CustomSpacers.height10,
            const Align(
              alignment: Alignment.center,
              child: RoundedImage.network(
                imagePath:
                    'https://s3-alpha-sig.figma.com/img/aaa5/7cde/eb5dc9a4df27f0bc3130236aaeaf54bb?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gsi7f~VbR2zxl120YaSV4wBVikRhepdBlDyTuC-CayojQZyegALo~fq2ZyqhmrHY9nbc9~uszlqrZu6YNvU7VeqouOXmN9mYiQf7g~w8a99oceXuynfNtuyN290C6g4BJEyD4ke0zGF28Pvebyxnvs26ZTqDFLDAzGWqjMXWn3LJteePknQOWt4mv4qXESARaRdEhLecTEG~Bhi1KuOX~Zh5sNAPjHmBLfEQj1RsxV6obWNTQH~MpOwSppUNSbcahpyKFhx0xyiEErhkG2lqlXq7Tn4xCNnIGq4gFWbQvSFWq3YOw6i6WILSzN9Nx9HMiz74IxwY7WhvnfSleWpA0A__',
                width: 300,
                height: 300,
              ),
            ),
            CustomSpacers.height10,
            const OffersSocialIcons(
              like: "0",
              share: "0",
              view: "",
            ),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Created on', value: '10/10/2022'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Status', value: 'Rejected'),
            CustomSpacers.height10,
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildButtons(context),
            ),
            CustomSpacers.height30,
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomFloatingActionButton(
          onPressed: () => CustomNavigator.pushTo(
            context,
            AppRouter.addAnnoucementScreen,
            arguments: AddAnnoucementFormType.edit,
          ),
          label: 'Edit this announcement',
        ),
        CustomSpacers.height30,
        GoBackButton(onTap: () => CustomNavigator.pop(context)),
      ],
    );
  }
}
