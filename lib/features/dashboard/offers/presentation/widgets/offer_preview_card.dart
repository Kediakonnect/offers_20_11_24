import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/social_icon_widget_offers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/profile_picture.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferPreviewCard extends StatelessWidget {
  final OffersCubit cubit;
  const OfferPreviewCard({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.primaryColor, width: 10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const ProfilePicture.network(
                path:
                    'https://c8.alamy.com/comp/DERFBR/colourful-indian-shop-in-puttaparthi-andhra-pradesh-india-DERFBR.jpg',
                size: 36,
              ),
              CustomSpacers.width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.selectedOffer?.offerTitle[0].title ?? '',
                    style: AppTextThemes.theme(context).displayMedium,
                  ),
                  Text(
                    cubit.selectedOffer?.categoryLevel1.name ?? '',
                    style: AppTextThemes.theme(context).bodyLarge,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          CustomSpacers.height20,
          SizedBox(
            width: double.maxFinite,
            height: 400.h,
            child: RoundedImage.network(
              // height: 680,
              width: double.maxFinite,
              imagePath: cubit.selectedOffer?.image ?? '',
            ),
          ),
          CustomSpacers.height20,
          SocialIconOffersWidget(
            offerModel: cubit.selectedOffer,
            onShareTapped: () {},
            onFavoriteTapped: () {},
            onLikeTapped: () {},
            onDislikeTapped: () {},
          )
        ],
      ),
    );
  }
}
