import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/share_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/bordered_text.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_card_secondary.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/image_preview.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/number_widget.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/social_icon_widget.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_screen_entity.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessEntity businessEntity;
  const BusinessDetailScreen({super.key, required this.businessEntity});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  late BusinessDirectoryCubit _businessDirectoryCubit;

  @override
  void initState() {
    _businessDirectoryCubit = sl<BusinessDirectoryCubit>();

    super.initState();
  }

  void _handleMenuItemClick(String value) {
    switch (value) {
      case 'Report':
        CustomNavigator.pushTo(
          context,
          AppRouter.createTicketScreen,
          arguments: CreateTicketScreenEntity(
              itemId: widget.businessEntity.businessId ?? ""),
        );
        break;
      case 'Verify':
        _businessDirectoryCubit.verifyBusiness(VerifyBusinessEntity(
          businessId: widget.businessEntity.businessId ?? "",
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBottomSheet: true,
      appBarTitle: 'Business Details'.toUpperCase(),
      body: BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
        bloc: _businessDirectoryCubit,
        listener: (context, state) {
          if (state is BusinessDirectoryFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
          if (state is BusinessDirectorySuccess) {
            ScaffoldHelper.showSuccessSnackBar(
                context: context, message: state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacers.height10,
                Row(
                  children: [
                    Text(
                      widget.businessEntity.name,
                      style: AppTextThemes.theme(context).displayMedium,
                    ),
                    const Spacer(),
                    PopupMenuButton<String>(
                      onSelected: _handleMenuItemClick,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Report',
                          child: Text('Report'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Verify',
                          child: Text('I Verify This Business'),
                        ),
                      ],
                      child: SvgPicture.asset(
                        AppIcons
                            .moreRounded, // Replace with your actual SVG path
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.businessEntity.categoryLevel1Value ?? "",
                  style: AppTextThemes.theme(context).bodyLarge,
                ),
                Visibility(
                  visible: widget.businessEntity.isVerified ?? false,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.verified,
                        height: 22.h,
                        width: 22.h,
                      ),
                      CustomSpacers.width10,
                      Text(
                        'Verified',
                        style:
                            AppTextThemes.theme(context).titleSmall?.copyWith(
                                  color: ColorPalette.primaryColor,
                                ),
                      ),
                    ],
                  ),
                ),
                CustomSpacers.height6,
                NumberWidget(
                  number: widget.businessEntity.mobile,
                ),
                CustomSpacers.height6,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.location,
                      color: ColorPalette.textDark,
                    ),
                    CustomSpacers.width10,
                    Text(
                      widget.businessEntity.registeredAddress,
                      style: AppTextThemes.theme(context).bodyLarge,
                    ),
                  ],
                ),
                Text(
                  '${widget.businessEntity.openingTime} - ${widget.businessEntity.closingTime}',
                  style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                        color: ColorPalette.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpacers.height10,
                ImagePreviewWidget(
                  primaryImage: widget.businessEntity.primaryImage,
                  secondaryImages: widget.businessEntity.secondaryImages,
                  isNetworkImages: widget.businessEntity.isNeworkImages,
                ),
                CustomSpacers.height10,
                Visibility(
                  visible: widget.businessEntity.websiteUrl.isNotEmpty,
                  child: _buildIconTile(
                    assetName: AppIcons.globe,
                    title: widget.businessEntity.websiteUrl,
                  ),
                ),
                CustomSpacers.height6,
                _buildIconTile(
                  assetName: AppIcons.message,
                  title: widget.businessEntity.email,
                ),
                CustomSpacers.height6,
                _buildIconTile(
                  assetName: AppIcons.whatsApp,
                  title: widget.businessEntity.whatsappNumber ?? '',
                  color: ColorPalette.primaryColor,
                ),
                SocialIconWidget(
                  onShareTapped: () {
                    shareBusiness(widget.businessEntity);
                  },
                  onFavoriteTapped: () {
                    _businessDirectoryCubit.addBusinessToFavorite(
                      AddBusinessToFavouriteEntity(
                        businessId: widget.businessEntity.businessId ?? '',
                        status: widget.businessEntity.isFavourite == true
                            ? '0'
                            : '1',
                      ),
                    );
                  },
                  onRate: (entity) {
                    _businessDirectoryCubit.rateBusiness(entity);
                  },
                  businessEntity: widget.businessEntity,
                ),

                // const SocialIconWidget(),
                Visibility(
                  visible: widget.businessEntity.offers != null &&
                      widget.businessEntity.offers!.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSpacers.height10,
                      const BorderedText(text: 'Offer available today'),
                      CustomSpacers.height16,
                      BusinessCardSecondary(
                        businessEntity: widget.businessEntity,
                        onTap: () {},
                      ),
                      CustomSpacers.height56,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future shareBusiness(BusinessEntity? entity) async {
    await Share.share(
      'Checkout my Business ${entity?.name ?? "Business Name"} on Divyam',
      subject: entity?.name ?? "Business Name",
    );

    _businessDirectoryCubit.shareBusiness(
      ShareBusinessEntity(
        businessId: entity?.businessId ?? "",
        status: "1",
      ),
    );
  }

  Widget _buildIconTile(
      {required String assetName,
      required String title,
      Color? color = ColorPalette.textDark}) {
    return Row(
      children: [
        SvgPicture.asset(assetName),
        CustomSpacers.width10,
        Text(
          title,
          style: AppTextThemes.theme(context).bodyLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}
