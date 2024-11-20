import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/social_icon_widget_offers.dart';
import 'package:divyam_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:divyam_flutter/features/onboarding/presentation/widgets/close_icon.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/atoms/shimmer_container.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddsWidget extends StatefulWidget {
  final String offerType;
  const AddsWidget({
    super.key,
    required this.offerType,
  });

  @override
  State<AddsWidget> createState() => _AddsWidgetState();
}

class _AddsWidgetState extends State<AddsWidget> {
  var img =
      'https://s3-alpha-sig.figma.com/img/bcfc/51b6/1945c529c29bf644101cb16b48d893e0?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=j9nU1HBY8Hj8kNjVjahTJi7KG1M9dEbW797llHBIKUQ~R22ATujzhYQxSCGpBkPlUETxTnR2dl6D3Q35UGdWO3JaDinHuvTRvI7ibfP6~OAYDieptWrrpk9UQWgMLUYcAT-qJh1ywrdxeiHj0VK-b96MLxM63zvf8~su1A9Udqwjlk9K-cs3tO2o3yiRM1fpW3dAHzT0ym94~ixoU1W7jxEZspXo7nlSKUcWLUh6AMnHnkm4oeB8qMoSAcmtWbAlQfi1tDGfcYugf2E00pSz9caGyCljtjkSE19uM3hyU-uAHHgkhjF0CoooLYi9TIy4mydoQPCYE9gmdh3gTHBZrA__';

  final _bloc = OnboardingCubit();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.getOffers(widget.offerType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorPalette.primaryColor,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * .95,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorPalette.scaffoldBackgroundColor,
            ),
            child: BlocConsumer<OnboardingCubit, OnboardingState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is GetOfferFailureState) {
                  if (widget.offerType == OfferType.entry.value) {
                    CustomNavigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.businessDirectoryScreen,
                    );
                  } else {
                    SystemNavigator.pop();
                  }
                }
              },
              builder: (context, state) {
                if (state is GetOfferSuccessState) {
                  return _buildBody(state.offerMode);
                }
                return const Center(
                  child: Loading(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(OfferModel data) {
    return Column(
      children: [
        _buildHeader(data),
        CustomSpacers.height20,
        CustomSpacers.height10,
        Expanded(
          child: RoundedImage.network(
            width: double.maxFinite,
            imagePath: data.image ?? img,
          ),
        ),
        CustomSpacers.height16,
        SocialIconOffersWidget(
          onShareTapped: () {},
          onFavoriteTapped: () {},
          onLikeTapped: () {},
          onDislikeTapped: () {},
          offerModel: data,
        ),
      ],
    );
  }

  Widget _buildHeader(OfferModel data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 36.h,
          width: 36.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              data.businessId?.primaryImage ?? img,
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
                data.businessId?.name ?? 'Divyam',
                style: AppTextThemes.theme(context).displayMedium,
              ),
              Text(
                data.categoryLevel1.name ?? 'Divyam',
                style: AppTextThemes.theme(context).bodyLarge,
              ),
            ],
          ),
        ),
        // const Spacer(),
        SvgPicture.asset(
          AppIcons.moreRounded,
        ),
        const Spacer(),
        CloseIcon(
          onClose: () {
            if (widget.offerType == OfferType.entry.value) {
              CustomNavigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.businessDirectoryScreen,
              );
            } else {
              SystemNavigator.pop();
            }
          },
        ),
      ],
    );
  }
}
