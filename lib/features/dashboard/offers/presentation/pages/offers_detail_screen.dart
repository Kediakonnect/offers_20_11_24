import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/extentions/date_time_extension.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/photo_view_screen.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_social_icons.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/zoomable_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/lable_value_display.dart';
import 'package:divyam_flutter/ui/moleclues/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class OffersDetailScreen extends StatefulWidget {
  final OfferModel entity;
  const OffersDetailScreen({super.key, required this.entity});

  @override
  State<OffersDetailScreen> createState() => _OffersDetailScreenState();
}

class _OffersDetailScreenState extends State<OffersDetailScreen> {
  late OffersCubit _offersCubit;

  @override
  void initState() {
    _offersCubit = sl<OffersCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My Offers'.toUpperCase(),
      body: BlocConsumer<OffersCubit, OffersState>(
        bloc: _offersCubit,
        listener: (context, state) {
          if (state is DeleteOfferFailureState) {
            ScaffoldHelper.showFailureSnackBar(
              context: context,
              message: state.message,
            );
          }
          if (state is DeleteOfferSuccessState) {
            CustomNavigator.pushTo(context, AppRouter.myOffersScreen);
            ScaffoldHelper.showSuccessSnackBar(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: FigmaValueConstants.defaultPaddingH.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacers.height20,
                CustomSpacers.height10,
                Visibility(
                  visible: widget.entity.offerTitle.isNotEmpty,
                  child: Text(
                    widget.entity.offerTitle[0].title,
                    style: AppTextThemes.theme(context).displayLarge,
                  ),
                ),
                CustomSpacers.height10,
                LabelValueWidget(label: 'Type', value: widget.entity.offerType),
                CustomSpacers.height10,
                Visibility(
                  visible: widget.entity.offerTitle.isNotEmpty,
                  child: LabelValueWidget(
                    label: 'Title',
                    value: widget.entity.offerTitle[0].title,
                  ),
                ),
                CustomSpacers.height10,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imageUrl: widget.entity.image!,
                          heroTag: "Offer",
                        ),
                      ),
                    );
                  },
                  child: RoundedImage.network(
                    height: 280,
                    width: double.infinity,
                    imagePath: widget.entity.image!,
                  ),
                ),
                CustomSpacers.height10,
                Visibility(
                  visible: widget.entity.offerTitle.isNotEmpty,
                  child: ReadMoreText(
                    widget.entity.offerTitle[0].description,
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                    style: AppTextThemes.theme(context)
                        .bodyLarge
                        ?.copyWith(fontSize: 16.sp),
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ),
                CustomSpacers.height10,
                LabelValueWidget(
                  label: 'Product category',
                  value: widget.entity.productId.name,
                ),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'This offer is for', value: widget.entity.targetSex),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Target age',
                    value: widget.entity.targetAllAges == '1'
                        ? 'All ages'
                        : '${widget.entity.fromAge} to ${widget.entity.toAge} years'),
                CustomSpacers.height10,
                const LabelValueWidget(
                    label: 'Target location', value: 'India'),
                CustomSpacers.height10,
                if (widget.entity.startDate != null &&
                    widget.entity.endDate != null) ...[
                  LabelValueWidget(
                      label: 'Start date',
                      value: widget.entity.startDate ?? ''),
                  CustomSpacers.height10,
                  LabelValueWidget(
                      label: 'End date', value: widget.entity.endDate ?? ''),
                  CustomSpacers.height10,
                ],
                OffersSocialIcons(
                  like: widget.entity.likeCount != null
                      ? widget.entity.likeCount.toString()
                      : "0",
                  share: widget.entity.shareCount != null
                      ? widget.entity.shareCount.toString()
                      : "0",
                  view: widget.entity.views != null
                      ? widget.entity.views.toString()
                      : "0",
                ),
                CustomSpacers.height10,
                LabelValueWidget(
                  label: 'Created on',
                  value: DateTime.parse(widget.entity.createdAt).formattedDate2,
                ),
                CustomSpacers.height10,
                LabelValueWidget(
                    label: 'Status', value: widget.entity.status ?? "Live"),
                CustomSpacers.height10,
                Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFloatingActionButton(
                            onPressed: () => _navigate(context, widget.entity),
                            label: 'Reuse this offer',
                          ),
                          CustomSpacers.width10,
                          CustomFloatingActionButton(
                            onPressed: () => _navigate(context, widget.entity),
                            label: 'Edit this offer',
                          ),
                          CustomSpacers.width10,
                        ],
                      ),
                    ),
                  ],
                ),
                CustomFloatingActionButton(
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  label: 'Delete this offer',
                  backgroundColor: ColorPalette.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigate(BuildContext context, OfferModel entity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOfferFormScreen(
          createOfferType: CreateOfferType.updateOffer,
          offer: entity,
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Offer"),
          content: const Text(
              "Are you sure you want to delete this offer? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: ColorPalette.primaryColor,
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _deleteOffer();
              },
              style: TextButton.styleFrom(
                foregroundColor: ColorPalette.red,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteOffer() {
    _offersCubit.deleteOffer(widget.entity.id ?? "");
  }
}
