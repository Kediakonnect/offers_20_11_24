import 'dart:math';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/event_social_icons.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/event_social_icon_widget.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/paid_event_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/themes/text_themes/text_themes.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  String sampleImage =
      "https://s3-alpha-sig.figma.com/img/4625/529a/09b168b68adcb9b754e4fdd3efbd95e5?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=P7TSkN4TUoD-kuswy14KYl39fyV~-I~rN9T59IkNk8tHTKqcNuMKEUiUVBoaQclngsP5ARR5nrPE~RDJP2b9bTn9hgn70WM0U003rx-C5y7O-WNmV4SjRNYZPEE6ilRF2AFOvj5UN97SvINZnuINBCBtrQh~4il9mIXGKbRrAkZFj9ktGQAXAwFAEYWbMxc3mVNt41Sk6kwbXSB29JPkYfIaqmJHXHpyswwRnjvgXdM76Y9BxQ~5RNyPEoKaFSv2XH2Eyd7PeO3EVUINhA9-8cOTrTCsCwxIaDaZLBdCvx~0FzjbX~NqFhtv6u2IyUH2PQcYLW5mNGAbS~1iHDtBmw__";
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'Event Details'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomSpacers.height20,
            Row(
              children: [
                Text(
                  'Mumbai Jazz Festival - 2023',
                  style: AppTextThemes.theme(context).displayMedium,
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.moreRounded,
                ),
              ],
            ),
            CustomSpacers.height20,
            // ImagePreviewWidget(
            //   url: sampleImage,
            // ),
            CustomSpacers.height20,
            const PaidEventWidget(),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Music Show', icon: AppIcons.category, context: context),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Hindi', icon: AppIcons.language, context: context),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Sat 27 Oct 2023 - Sun 28 Oct 2023',
                icon: AppIcons.calender,
                context: context),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Phoenix Palladium, Lower Parel, Mumbai',
                icon: AppIcons.location,
                context: context),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Lions Club Khamgaon',
                icon: AppIcons.manager,
                context: context),
            CustomSpacers.height10,
            _buildIconText(
                text: 'Hon. Dr. Arvind Suradkar',
                icon: AppIcons.idCard,
                context: context),
            CustomSpacers.height10,
            _buildIconText(
                text:
                    'This is a very, very long description of a useless event',
                icon: AppIcons.notes,
                context: context),
            CustomSpacers.height10,
            _buildIconText(
                text:
                    'XYZ stores, Balaji Plots: 9876543210 ABC shop, Ghatpuri Naka: 0123456987',
                icon: AppIcons.msg,
                context: context),
            CustomSpacers.height20,
            _buildSocialIcons(),
            CustomSpacers.height120,
            // _buildSocialIcons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: EventSocialIcons.values
          .map((e) => EventSocialIconWidget(
              text: e.name,
              icon: e.assetName,
              count: Random().nextInt(100).toString(),
              onTap: () {}))
          .toList(),
    );
  }

  Widget _buildIconText(
      {required String text,
      required String icon,
      required BuildContext context}) {
    return Row(
      children: [
        SvgPicture.asset(
          color: ColorPalette.textDark,
          icon,
          height: 20,
          width: 20,
        ),
        CustomSpacers.width10,
        Expanded(
            child: Text(text, style: AppTextThemes.theme(context).bodyLarge)),
      ],
    );
  }
}
