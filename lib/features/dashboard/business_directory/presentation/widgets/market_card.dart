import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/bordered_text.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/social_icon_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MarketCard extends StatelessWidget {
  final BusinessEntity businessEntity;
  final VoidCallback onTap;
  final VoidCallback onShareTaped;
  final Function(RateBusinessEntity entity) onRate;
  final VoidCallback onFavoriteTapped;
  final VoidCallback? onVerifyTapped;

  const MarketCard({
    super.key,
    required this.onTap,
    required this.businessEntity,
    required this.onShareTaped,
    required this.onRate,
    required this.onFavoriteTapped,
    this.onVerifyTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: NeuroMorphicContainer(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextLeftView(context),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: businessEntity.isNeworkImages!
                      ? RoundedImage.network(
                          height: 105,
                          width: 105,
                          imagePath: businessEntity.primaryImage,
                        )
                      : RoundedImage.file(
                          height: 105,
                          width: 105,
                          imagePath: businessEntity.primaryImage,
                        ),
                ),
              ],
            ),
            CustomSpacers.height6,
            SocialIconWidget(
              onRate: (entity) => onRate(entity),
              onShareTapped: () => onShareTaped(),
              onFavoriteTapped: () => onFavoriteTapped(),
              businessEntity: businessEntity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextLeftView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            businessEntity.name,
            style: AppTextThemes.theme(context).displayMedium,
          ),
          CustomSpacers.height6,
          Text(
            businessEntity.categoryLevel1Value ?? "",
            style: AppTextThemes.theme(context).bodyLarge,
          ),
          CustomSpacers.height10,
          if (businessEntity.isVerified != false)
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.verified,
                  height: 22.h,
                  width: 22.h,
                ),
                CustomSpacers.width10,
                Text(
                  'Verified',
                  style: AppTextThemes.theme(context).titleSmall?.copyWith(
                        color: ColorPalette.primaryColor,
                      ),
                ),
              ],
            ),
          if (businessEntity.isVerified == false)
            GestureDetector(
              onTap: () {
                if (onVerifyTapped != null) {
                  onVerifyTapped!();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.05), // Shadow color with opacity
                      blurRadius: 4, // Blur radius for a soft shadow
                      offset: const Offset(2, 2), // Position of the shadow
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  "Verify this Business",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ),
          CustomSpacers.height10,
          Visibility(
            visible: businessEntity.offers != null &&
                businessEntity.offers!.isNotEmpty,
            child: const BorderedText(text: 'Offer available today'),
          ),
          CustomSpacers.height6,
          Text(
            businessEntity.registeredAddress,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ],
      ),
    );
  }
}
