import 'dart:math';

import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/widgets/event_social_icon_widget.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class FamousCard extends StatelessWidget {
  final String? imagePath;
  const FamousCard({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return NeuroMorphicContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Visibility(
            visible: imagePath != null,
            child: const RoundedImage.network(
              imagePath:
                  'https://s3-alpha-sig.figma.com/img/aaa5/7cde/eb5dc9a4df27f0bc3130236aaeaf54bb?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gsi7f~VbR2zxl120YaSV4wBVikRhepdBlDyTuC-CayojQZyegALo~fq2ZyqhmrHY9nbc9~uszlqrZu6YNvU7VeqouOXmN9mYiQf7g~w8a99oceXuynfNtuyN290C6g4BJEyD4ke0zGF28Pvebyxnvs26ZTqDFLDAzGWqjMXWn3LJteePknQOWt4mv4qXESARaRdEhLecTEG~Bhi1KuOX~Zh5sNAPjHmBLfEQj1RsxV6obWNTQH~MpOwSppUNSbcahpyKFhx0xyiEErhkG2lqlXq7Tn4xCNnIGq4gFWbQvSFWq3YOw6i6WILSzN9Nx9HMiz74IxwY7WhvnfSleWpA0A__',
              width: 300,
              height: 300,
            ),
          ),
          CustomSpacers.height10,
          Row(
            children: [
              Text(
                'Happy Birthday Amit',
                style: AppTextThemes.theme(context).displayLarge,
              ),
              const Spacer(),
              SvgPicture.asset(
                AppIcons.moreRounded,
              ),
            ],
          ),
          CustomSpacers.height10,
          Text(
            "I think today should be a national holiday, but until they make that official, let's just do our best by eating cake, drinking champagne, and blowing off as many responsibilities as possible.",
            style: AppTextThemes.theme(context).bodyLarge,
          ),
          CustomSpacers.height20,
          _buildSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EventSocialIconWidget(
          text: 'Share',
          icon: AppIcons.share,
          count: Random().nextInt(100).toString(),
          onTap: () {},
        ),
        EventSocialIconWidget(
          text: 'Like',
          icon: AppIcons.like,
          count: Random().nextInt(100).toString(),
          onTap: () {},
        ),
        EventSocialIconWidget(
          text: 'Favorite',
          icon: AppIcons.favourite,
          count: Random().nextInt(100).toString(),
          onTap: () {},
        ),
      ],
    );
  }
}
