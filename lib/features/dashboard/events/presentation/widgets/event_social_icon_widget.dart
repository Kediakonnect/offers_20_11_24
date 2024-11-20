import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

class EventSocialIconWidget extends StatelessWidget {
  final String text, icon, count;
  final VoidCallback onTap;
  const EventSocialIconWidget(
      {super.key,
      required this.text,
      required this.icon,
      required this.count,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count,
          style: AppTextThemes.theme(context).bodySmall,
        ),
        CustomSpacers.height10,
        GestureDetector(
          onTap: onTap,
          child: NeuroMorphicContainer(
            padding: const EdgeInsets.all(8),
            shape: BoxShape.circle,
            child: SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
            ),
          ),
        ),
        CustomSpacers.height10,
        Text(
          text,
          style: AppTextThemes.theme(context).bodySmall,
        ),
      ],
    );
  }
}
