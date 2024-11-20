import 'package:divyam_flutter/core/enums/social_options.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_rating_modal.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconWidget extends StatefulWidget {
  final BusinessEntity? businessEntity;
  final VoidCallback onShareTapped;
  final VoidCallback onFavoriteTapped;
  final Function(RateBusinessEntity entity) onRate;
  const SocialIconWidget({
    super.key,
    required this.onRate,
    this.businessEntity,
    required this.onShareTapped,
    required this.onFavoriteTapped,
  });

  @override
  State<SocialIconWidget> createState() => _SocialIconWidgetState();
}

class _SocialIconWidgetState extends State<SocialIconWidget> {
  @override
  void initState() {
    super.initState();
  }

  void openGoogleMap(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void openDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  void _onIconTap(SocialOptions option, BuildContext context) {
    switch (option) {
      case SocialOptions.share:
        widget.onShareTapped();
        break;
      case SocialOptions.rate:
        showDialog(
          context: context,
          builder: (context) => BusinessRatingModal(
            onConfirmTap: (val) {
              widget.onRate(val);
              Navigator.pop(context);
            },
            businessEntity: widget.businessEntity,
          ),
        );
        break;
      case SocialOptions.call:
        openDialer(widget.businessEntity?.mobile ?? "");
        break;
      case SocialOptions.location:
        if (widget.businessEntity?.googleMapLink != null &&
            widget.businessEntity!.googleMapLink.isNotEmpty) {
          openGoogleMap(widget.businessEntity?.googleMapLink ?? "");
        } else {
          Fluttertoast.showToast(
            msg: "Google map link not provided",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
        break;
      case SocialOptions.favourite:
        widget.onFavoriteTapped();
        break;
    }
  }

  String _showCount(SocialOptions option, BuildContext context) {
    switch (option) {
      case SocialOptions.share:
        return widget.businessEntity?.shareCount != null
            ? widget.businessEntity!.shareCount.toString()
            : "0";
      case SocialOptions.rate:
        return widget.businessEntity?.rating != null
            ? widget.businessEntity!.rating.toString()
            : "0";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: SocialOptions.values.map((e) {
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
                  _onIconTap(e, context);
                },
                child: NeuroMorphicContainer(
                  isSharpWhite: true,
                  padding: const EdgeInsets.all(8),
                  height: 36.h,
                  width: 36.w,
                  shape: BoxShape.circle,
                  child: e == SocialOptions.favourite
                      ? widget.businessEntity!.isFavourite == true
                          ? Icon(
                              Icons.favorite,
                              size: 20.w,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 20.w,
                              color: Colors.red,
                            )
                      : SvgPicture.asset(
                          e.assetName,
                          height: 20,
                          width: 20,
                        ),
                ),
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
