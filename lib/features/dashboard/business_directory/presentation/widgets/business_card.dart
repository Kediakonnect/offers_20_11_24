import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/business_status.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_status.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/profile_picture.dart';
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final BusinessEntity data;
  final BusinessStatusType status;
  final VoidCallback onTap;
  const BusinessCard(
      {super.key,
      required this.status,
      required this.onTap,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * .41,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BusinessStatusWidget(
              status: status,
            ),
            CustomSpacers.height16,
            if (data.logoImage != null)
              ProfilePicture.network(path: data.logoImage ?? ''),
            CustomSpacers.height10,
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              data.name,
              style: AppTextThemes.theme(context).displayLarge,
            ),
            CustomSpacers.height6,
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              data.talukaValue ?? '',
              style: AppTextThemes.theme(context).bodyMedium,
            ),
            CustomSpacers.height6,
            Text(
              data.mobile,
              style: AppTextThemes.theme(context).bodyMedium,
            ),
            CustomSpacers.height6,
            Row(
              children: [
                _buildIconText(
                    icon: Icons.star,
                    text: data.rating != null ? data.rating.toString() : '0',
                    context: context),
                CustomSpacers.width10,
                _buildIconText(
                    icon: Icons.share,
                    text: data.shareCount != null
                        ? data.shareCount.toString()
                        : '0',
                    context: context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(
      {required String text,
      required IconData icon,
      required BuildContext context}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorPalette.textDark,
          size: 13,
        ),
        CustomSpacers.width10,
        Text(
          text,
          style: AppTextThemes.theme(context).bodyMedium,
        ),
      ],
    );
  }
}
