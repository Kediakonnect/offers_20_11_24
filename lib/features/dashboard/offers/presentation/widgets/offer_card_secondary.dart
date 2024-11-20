import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/social_icon_widget_offers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

class OfferCardSecondary extends StatelessWidget {
  final OfferModel offerModel;
  final VoidCallback onTap;
  final VoidCallback onShareTapped;
  final VoidCallback onFavoriteTapped;
  final VoidCallback onLikeTapped;
  final VoidCallback onDislikeTapped;
  const OfferCardSecondary({
    super.key,
    required this.onTap,
    required this.offerModel,
    required this.onShareTapped,
    required this.onFavoriteTapped,
    required this.onLikeTapped,
    required this.onDislikeTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            CustomSpacers.height10,
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff28C76F), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 9.w,
                vertical: 4.h,
              ),
              child: Text(
                offerModel.offerTitle[0].title,
                style: AppTextThemes.theme(context).displayMedium,
              ),
            ),
            CustomSpacers.height10,
            _buildSeeMoreText(context),
            CustomSpacers.height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  // ignore: unnecessary_null_comparison
                  visible: offerModel.originalPrice != null,
                  child: Text('MRP: ₹${offerModel.originalPrice}'),
                ),
                Visibility(
                  visible: offerModel.offerPrice != null,
                  child: Text('Discount Price: ₹${offerModel.offerPrice}'),
                ),
              ],
            ),
            CustomSpacers.height10,
            RoundedImage.network(
              height: 295,
              width: double.maxFinite,
              imagePath: offerModel.image ?? '',
            ),
            CustomSpacers.height16,
            SocialIconOffersWidget(
              onShareTapped: () {
                onShareTapped();
              },
              onFavoriteTapped: () {
                onFavoriteTapped();
              },
              onDislikeTapped: () {
                onDislikeTapped();
              },
              onLikeTapped: () {
                onLikeTapped();
              },
              offerModel: offerModel,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSeeMoreText(BuildContext context) {
    return Visibility(
      visible: offerModel.offerTitle.isNotEmpty,
      child: ReadMoreText(
        offerModel.offerTitle[0].description,
        trimMode: TrimMode.Line,
        trimLines: 1,
        style:
            AppTextThemes.theme(context).bodyLarge?.copyWith(fontSize: 16.sp),
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ColorPalette.textPlaceholder,
        ),
        lessStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: ColorPalette.primaryColor,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 36.h,
          width: 36.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              offerModel.businessId?.primaryImage ?? offerModel.image ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomSpacers.width10,
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offerModel.businessId?.name ?? '',
                style: AppTextThemes.theme(context).displayMedium,
              ),
              Text(
                offerModel.productId.name ?? '',
                style: AppTextThemes.theme(context).bodyLarge,
              ),
            ],
          ),
        ),
        // const Spacer(),
        SvgPicture.asset(
          AppIcons.moreRounded,
        ),
        CustomSpacers.width10,
        NeuroMorphicContainer(
          padding: const EdgeInsets.all(2),
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          child: SvgPicture.asset(
            AppIcons.call,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
