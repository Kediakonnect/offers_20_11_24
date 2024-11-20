import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/event_form_type.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/suspended_box.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_chip.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/go_back_btn.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyEventDetailScreenTwo extends StatelessWidget {
  const MyEventDetailScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    String sampleImage =
        "https://s3-alpha-sig.figma.com/img/4625/529a/09b168b68adcb9b754e4fdd3efbd95e5?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=P7TSkN4TUoD-kuswy14KYl39fyV~-I~rN9T59IkNk8tHTKqcNuMKEUiUVBoaQclngsP5ARR5nrPE~RDJP2b9bTn9hgn70WM0U003rx-C5y7O-WNmV4SjRNYZPEE6ilRF2AFOvj5UN97SvINZnuINBCBtrQh~4il9mIXGKbRrAkZFj9ktGQAXAwFAEYWbMxc3mVNt41Sk6kwbXSB29JPkYfIaqmJHXHpyswwRnjvgXdM76Y9BxQ~5RNyPEoKaFSv2XH2Eyd7PeO3EVUINhA9-8cOTrTCsCwxIaDaZLBdCvx~0FzjbX~NqFhtv6u2IyUH2PQcYLW5mNGAbS~1iHDtBmw__";
    return CustomScaffold(
      appBarTitle: 'My events'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height30,
            SuspendedBox(
                message:
                    'This event has been rejected because of reported violation of privacy',
                onDetailTap: () => CustomNavigator.pushTo(
                    context, AppRouter.issuesResolutionScreen)),
            CustomSpacers.height20,
            Text(
              'Mumbai Jazz Festival - 2023',
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height12,
            const CustomChip(color: ColorPalette.red, text: 'Rejected'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Event category', value: 'Music Show'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Language', value: 'Marathi'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Start date & time', value: '12-12-2023 06:30 PM'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'End date & time', value: '12-12-2023 06:30 PM'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Organizer', value: 'Lions Club Andheri Mumbai'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Chief guest', value: 'Hon. Dr. Arvind Suradkar'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Description',
                value:
                    'This is a very, very long description of a useless event'),
            CustomSpacers.height10,
            // ImagePreviewWidget(
            // url: sampleImage,
            // ),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Paid event', value: 'Yes'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'State', value: 'Punjab'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Metro city', value: 'Mumbai'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Area', value: 'Andheri'),
            CustomSpacers.height10,
            const LabelValueWidget(
                label: 'Venue',
                value: 'Phoenix Palladium, Lower Parel, Mumbai'),
            CustomSpacers.height10,
            const OffersSocialIcons(
              like: "0",
              share: "0",
              view: "0",
            ),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Created on', value: '23-09-2023'),
            CustomSpacers.height10,
            const LabelValueWidget(label: 'Status', value: 'Rejected'),
            CustomSpacers.height30,
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildButtons(context)),
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
            AppRouter.myEventForm,
            arguments: EventFormType.edit,
          ),
          label: 'Edit this event',
        ),
        CustomSpacers.height30,
        GoBackButton(onTap: () => CustomNavigator.pop(context)),
      ],
    );
  }
}
