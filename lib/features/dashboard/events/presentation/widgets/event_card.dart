import 'dart:math';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/event_social_icons.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/event_social_icon_widget.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/paid_event_widget.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/ui/moleclues/custom_chip.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum EventCardType { primary, secandory }

class EventCard extends StatelessWidget {
  final EventCardType? type;
  final VoidCallback onTap;
  const EventCard(
      {super.key, required this.onTap, this.type = EventCardType.primary});

  @override
  Widget build(BuildContext context) {
    String sampleImage =
        "https://s3-alpha-sig.figma.com/img/4625/529a/09b168b68adcb9b754e4fdd3efbd95e5?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=P7TSkN4TUoD-kuswy14KYl39fyV~-I~rN9T59IkNk8tHTKqcNuMKEUiUVBoaQclngsP5ARR5nrPE~RDJP2b9bTn9hgn70WM0U003rx-C5y7O-WNmV4SjRNYZPEE6ilRF2AFOvj5UN97SvINZnuINBCBtrQh~4il9mIXGKbRrAkZFj9ktGQAXAwFAEYWbMxc3mVNt41Sk6kwbXSB29JPkYfIaqmJHXHpyswwRnjvgXdM76Y9BxQ~5RNyPEoKaFSv2XH2Eyd7PeO3EVUINhA9-8cOTrTCsCwxIaDaZLBdCvx~0FzjbX~NqFhtv6u2IyUH2PQcYLW5mNGAbS~1iHDtBmw__";

    return NeuroMorphicContainer(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (type == EventCardType.secandory) ...[
            const CustomChip(color: ColorPalette.green, text: 'Live'),
            CustomSpacers.height20,
          ],
          Text(
            'Mumbai Jazz Festival - 2023',
            style: AppTextThemes.theme(context).titleLarge,
          ),
          CustomSpacers.height10,
          GestureDetector(
            onTap: onTap,
            child: RoundedImage.network(
              height: 280,
              width: double.maxFinite,
              imagePath: sampleImage,
            ),
          ),
          CustomSpacers.height10,
          const PaidEventWidget(),
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
          _buildSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    if (type == EventCardType.secandory) {
      return const OffersSocialIcons(
        like: "0",
        share: "0",
        view: "0",
      );
    }
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
