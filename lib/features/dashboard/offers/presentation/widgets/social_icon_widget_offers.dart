import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/social_options_offer.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialIconOffersWidget extends StatefulWidget {
  final OfferModel? offerModel;
  final VoidCallback onShareTapped;
  final VoidCallback onFavoriteTapped;
  final VoidCallback onLikeTapped;
  final VoidCallback onDislikeTapped;

  const SocialIconOffersWidget({
    super.key,
    this.offerModel,
    required this.onShareTapped,
    required this.onFavoriteTapped,
    required this.onLikeTapped,
    required this.onDislikeTapped,
  });

  @override
  State<SocialIconOffersWidget> createState() => _SocialIconOffersWidgetState();
}

class _SocialIconOffersWidgetState extends State<SocialIconOffersWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _onIconTap(SocialOptionsOffers option, BuildContext context) {
    switch (option) {
      case SocialOptionsOffers.share:
        widget.onShareTapped();
        break;

      case SocialOptionsOffers.favorite:
        widget.onFavoriteTapped();
        break;
      case SocialOptionsOffers.like:
        widget.onLikeTapped();
        break;
      case SocialOptionsOffers.dislike:
        widget.onDislikeTapped();
        break;
      case SocialOptionsOffers.view:
        break;
    }
  }

  String _showCount(SocialOptionsOffers option, BuildContext context) {
    switch (option) {
      case SocialOptionsOffers.like:
        return widget.offerModel?.likeCount != null
            ? widget.offerModel!.likeCount.toString()
            : "0";
      case SocialOptionsOffers.dislike:
        return widget.offerModel?.dislikeCount != null
            ? widget.offerModel!.dislikeCount.toString()
            : "0";
      case SocialOptionsOffers.share:
        return widget.offerModel?.shareCount != null
            ? widget.offerModel!.shareCount.toString()
            : "0";
      case SocialOptionsOffers.view:
        return widget.offerModel?.views != null
            ? widget.offerModel!.views.toString()
            : "0";
      case SocialOptionsOffers.favorite:
        return widget.offerModel?.favoriteCount != null
            ? widget.offerModel!.favoriteCount.toString()
            : "0";
      default:
        return "0";
    }
  }

  Widget _showIcon(
      SocialOptionsOffers option, BuildContext context, OfferModel model) {
    switch (option) {
      case SocialOptionsOffers.share:
        return SvgPicture.asset(AppIcons.share);
      case SocialOptionsOffers.like:
        return Icon(
          model.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
          size: 20.sp,
          color: ColorPalette.green,
        );
      case SocialOptionsOffers.dislike:
        return Icon(
          model.isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
          size: 20.sp,
          color: Colors.grey,
        );
      case SocialOptionsOffers.view:
        return Icon(
          Icons.remove_red_eye,
          size: 20.sp,
          color: ColorPalette.blue,
        );
      case SocialOptionsOffers.favorite:
        return Icon(
          model.isFavourite ? Icons.favorite : Icons.favorite_outline,
          size: 20.sp,
          color: ColorPalette.red,
        );

      default:
        return SvgPicture.asset(AppImages.feature);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: SocialOptionsOffers.values.map((e) {
        return SizedBox(
          width: 45.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _showCount(e, context),
                style: AppTextThemes.theme(context).bodySmall?.copyWith(
                      fontSize: 10.sp,
                      height: 12.sp / 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              CustomSpacers.height10,
              GestureDetector(
                onTap: () {
                  if (widget.offerModel != null) {
                    _onIconTap(e, context);
                  }
                },
                child: widget.offerModel != null
                    ? NeuroMorphicContainer(
                        isSharpWhite: true,
                        padding: const EdgeInsets.all(8),
                        height: 36.h,
                        width: 36.w,
                        shape: BoxShape.circle,
                        child: _showIcon(e, context, widget.offerModel!),
                      )
                    : const SizedBox(), // Render an empty widget if offerModel is null
              ),
              CustomSpacers.height10,
              Text(
                e.name,
                style: AppTextThemes.theme(context).bodySmall?.copyWith(
                      fontSize: 10.sp,
                      height: 12.sp / 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
