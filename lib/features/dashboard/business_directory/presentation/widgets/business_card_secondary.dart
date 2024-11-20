import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BusinessCardSecondary extends StatelessWidget {
  final BusinessEntity businessEntity;
  final VoidCallback onTap;
  const BusinessCardSecondary(
      {super.key, required this.onTap, required this.businessEntity});

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
            _buildSeeMoreText(context),
            CustomSpacers.height10,
            RoundedImage.network(
              height: 295,
              width: double.maxFinite,
              imagePath: businessEntity.offers![0].image,
            ),
            CustomSpacers.height16,
            // const SocialIconWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSeeMoreText(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Text(
            businessEntity.offers?[0].offerTitle[0].description ?? '',
            overflow: TextOverflow.ellipsis,
            style: AppTextThemes.theme(context).bodyLarge,
          ),
        ),
        const Spacer(),
      ],
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
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
                businessEntity.logoImage ?? businessEntity.primaryImage),
          ),
        ),
        CustomSpacers.width10,
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                businessEntity.offers![0].offerTitle[0].title ?? '',
                style: AppTextThemes.theme(context).displayMedium,
              ),
              Text(
                '${businessEntity.offers?[0].categoryLevel1.name}',
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
