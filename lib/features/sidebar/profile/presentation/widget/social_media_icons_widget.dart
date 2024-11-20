import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/social_options.dart';
import 'package:divyam_flutter/core/themes/app_themes.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaIconsWidget extends StatelessWidget {
  const SocialMediaIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.whatsAppColored,
            height: 20,
            width: 20,
          ),
        ),
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.facebook,
            height: 20,
            width: 20,
          ),
        ),
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.messageColor,
            height: 20,
            width: 20,
          ),
        ),
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.instagram,
            height: 20,
            width: 20,
          ),
        ),
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.share,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
