import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/offer_status.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';

class AnnoucementTile extends StatelessWidget {
  final OfferStatusType status;
  final VoidCallback onTap;
  const AnnoucementTile({super.key, required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildImage(),
            CustomSpacers.width10,
            _buildText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            decoration: BoxDecoration(
              color: status.color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              status.name,
              style: AppTextThemes.theme(context).bodySmall?.copyWith(
                    color: ColorPalette.scaffoldBackgroundColor,
                  ),
            ),
          ),
          CustomSpacers.height10,
          Text(
            'Happy Birthday Amit!',
            overflow: TextOverflow.ellipsis,
            style: AppTextThemes.theme(context).displayMedium,
          ),
          CustomSpacers.height10,
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            '13-12-2023',
            style: AppTextThemes.theme(context).bodyMedium,
          ),
          CustomSpacers.height10,
          const OffersSocialIcons(
            like: "0",
            share: "0",
            view: "0",
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return const RoundedImage.network(
      height: 120,
      width: 120,
      imagePath:
          'https://s3-alpha-sig.figma.com/img/aaa5/7cde/eb5dc9a4df27f0bc3130236aaeaf54bb?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gsi7f~VbR2zxl120YaSV4wBVikRhepdBlDyTuC-CayojQZyegALo~fq2ZyqhmrHY9nbc9~uszlqrZu6YNvU7VeqouOXmN9mYiQf7g~w8a99oceXuynfNtuyN290C6g4BJEyD4ke0zGF28Pvebyxnvs26ZTqDFLDAzGWqjMXWn3LJteePknQOWt4mv4qXESARaRdEhLecTEG~Bhi1KuOX~Zh5sNAPjHmBLfEQj1RsxV6obWNTQH~MpOwSppUNSbcahpyKFhx0xyiEErhkG2lqlXq7Tn4xCNnIGq4gFWbQvSFWq3YOw6i6WILSzN9Nx9HMiz74IxwY7WhvnfSleWpA0A__',
    );
  }
}
