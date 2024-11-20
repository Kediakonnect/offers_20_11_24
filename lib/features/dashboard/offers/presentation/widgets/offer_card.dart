import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';

class MyOfferCard extends StatelessWidget {
  final OfferModel offerModel;
  final VoidCallback onTap;
  const MyOfferCard({super.key, required this.offerModel, required this.onTap});

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
            _buildImage(offerModel.image ?? ''),
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
              color: ColorPalette.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              offerModel.status ?? '',
              style: AppTextThemes.theme(context).bodySmall?.copyWith(
                    color: ColorPalette.scaffoldBackgroundColor,
                  ),
            ),
          ),
          CustomSpacers.height10,
          Text(
            offerModel.offerTitle[0].title ?? '',
            overflow: TextOverflow.ellipsis,
            style: AppTextThemes.theme(context).displayMedium,
          ),
          CustomSpacers.height10,
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            offerModel.offerTitle[0].description ?? '',
            style: AppTextThemes.theme(context).bodyMedium,
          ),
          Text(
            offerModel.businessId?.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: AppTextThemes.theme(context).displaySmall,
          ),
          CustomSpacers.height10,
          // const OffersSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return RoundedImage.network(
      height: 120,
      width: 120,
      imagePath: image,
    );
  }
}
