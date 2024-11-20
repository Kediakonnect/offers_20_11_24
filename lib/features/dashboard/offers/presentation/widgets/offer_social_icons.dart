import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';

class OffersSocialIcons extends StatelessWidget {
  final String like;
  final String share;
  final String view;

  const OffersSocialIcons({
    super.key,
    required this.like,
    required this.share,
    required this.view,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSocialIcons(context: context, text: like, icon: Icons.thumb_up),
        CustomSpacers.width10,
        _buildSocialIcons(context: context, text: share, icon: Icons.share),
        CustomSpacers.width10,
        _buildSocialIcons(
            context: context, text: view, icon: Icons.remove_red_eye),
      ],
    );
  }

  Widget _buildSocialIcons(
      {required BuildContext context,
      required String text,
      required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 11,
          color: ColorPalette.textDark,
        ),
        CustomSpacers.width10,
        Text(text, style: AppTextThemes.theme(context).bodyMedium),
      ],
    );
  }
}
