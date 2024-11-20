import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/category_filter_widget.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/state_filter_widget.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_card_secondary.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/atoms/visibility_detector.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/dash_board_action_btns.dart';
import 'package:divyam_flutter/ui/moleclues/disabled_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/constants/color_palette.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late OffersCubit _offersCubit;
  late BusinessCategoryCubit _businessCategoryCubit;
  late StateSelectorCubit _selectorCubit;
  List<OfferModel> allOffers = [];

  @override
  void initState() {
    _offersCubit = sl<OffersCubit>();
    _businessCategoryCubit = sl<BusinessCategoryCubit>();
    _selectorCubit = sl<StateSelectorCubit>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _offersCubit.getAllBOffers(isOptimisticUpdate: false);
      _selectorCubit.getStates();
      // _businessCategoryCubit.getCategories(CategoryEntity());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: DashBoardActionButtons(
        onAddPressed: () =>
            CustomNavigator.pushTo(context, AppRouter.myOffersScreen),
        onMlmPressed: () {},
      ),
      enableBottomSheet: true,
      appBarTitle: 'Offers'.toUpperCase(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StateSelectorCubit, StateSelectorState>(
            bloc: _selectorCubit,
            listener: (context, state) {
              if (_selectorCubit.selectedState != null) {
                _offersCubit
                    .stateFilterChanged(_selectorCubit.selectedState!.id);
              }
              if (_selectorCubit.selectedDistrict != null) {
                _offersCubit
                    .cityFilterChanged(_selectorCubit.selectedDistrict!.id);
              }
              if (_selectorCubit.selectedTaluka != null) {
                _offersCubit
                    .talukaFilterChanged(_selectorCubit.selectedTaluka!.id);
              }
            },
          ),
          BlocListener<BusinessCategoryCubit, BusinessCategoryState>(
            bloc: _businessCategoryCubit,
            listener: (context, state) {
              if (_businessCategoryCubit.category1 != null) {
                _offersCubit.categoryFilterLevel1Changed(
                    _businessCategoryCubit.category1!.id);
              }
              if (_businessCategoryCubit.category2 != null) {
                _offersCubit.categoryFilterLevel2Changed(
                    _businessCategoryCubit.category2!.id);
              }
              if (_businessCategoryCubit.category3 != null) {
                _offersCubit.categoryFilterLevel3Changed(
                    _businessCategoryCubit.category3!.id);
              }
              if (_businessCategoryCubit.category4 != null) {
                _offersCubit.productCategoryChanged(
                  _businessCategoryCubit.category4!.id,
                );
              }
            },
          ),
        ],
        child: BlocConsumer<OffersCubit, OffersState>(
          bloc: _offersCubit,
          buildWhen: (previous, current) => current is! OffersOptimisticState,
          listener: (context, state) {
            if (state is GetAllOffersFailure) {
              ScaffoldHelper.showFailureSnackBar(
                  context: context, message: state.message);
            }

            if (state is GetAllOffersSuccessState) {
              allOffers = state.data;
            }

            if (state is AddOffersToFavoriteSuccessState) {
              _offersCubit.refetch();
            }
          },
          builder: (context, state) {
            if (state is GetAllOffersLoading) {
              return const Loading();
            }

            if (allOffers.isNotEmpty) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CustomSpacers.height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DisabledDropDown(
                          onTap: () => _showCategoryBottomSheet(),
                          hintText: 'Filter',
                        ),
                        CustomSpacers.width10,
                        DisabledDropDown(
                          onTap: () => _showStateBottomSheet(),
                          hintText:
                              _selectorCubit.selectedTaluka?.name ?? "Location",
                        ),
                        CustomSpacers.height20,
                      ],
                    ),
                    CustomSpacers.height20,
                    for (var s in allOffers) ...[
                      VisibilityWrapper(
                        id: s.id ?? s.offerTitle.first.title,
                        child: OfferCardSecondary(
                          onTap: () {
                            CustomNavigator.pushTo(
                                context, AppRouter.offerDetailScreen,
                                arguments: s);
                          },
                          onDislikeTapped: () {
                            if (s.isLiked) {
                              _offersCubit.performSocialAction(
                                entity: OfferSocialEntity(
                                  url: likeOfferUrl,
                                  offerId: s.id ?? "",
                                  status: s.isLiked ? "0" : "1",
                                ),
                              );
                            }
                            _offersCubit.performSocialAction(
                              entity: OfferSocialEntity(
                                url: dislikeOfferUrl,
                                offerId: s.id ?? "",
                                status: s.isDisliked ? "0" : "1",
                              ),
                            );
                          },
                          onFavoriteTapped: () {
                            _offersCubit.performSocialAction(
                              entity: OfferSocialEntity(
                                  url: favoriteOfferUrl,
                                  offerId: s.id ?? "",
                                  status: s.isFavourite ? "0" : "1"),
                            );
                          },
                          onLikeTapped: () {
                            if (s.isDisliked) {
                              _offersCubit.performSocialAction(
                                entity: OfferSocialEntity(
                                  url: dislikeOfferUrl,
                                  offerId: s.id ?? "",
                                  status: s.isDisliked ? "0" : "1",
                                ),
                              );
                            }
                            _offersCubit.performSocialAction(
                              entity: OfferSocialEntity(
                                url: likeOfferUrl,
                                offerId: s.id ?? "",
                                status: s.isLiked ? "0" : "1",
                              ),
                            );
                          },
                          onShareTapped: () async {
                            await Share.share(
                              'Checkout my Offer ${s.offerTitle.first.title} on Divyam',
                              subject: s.offerTitle.first.title,
                            );

                            _offersCubit.performSocialAction(
                              entity: OfferSocialEntity(
                                url: offerShareUrl,
                                offerId: s.id ?? "",
                                status: "1",
                              ),
                            );
                          },
                          offerModel: s,
                        ),
                        onVisible: () {
                          _offersCubit.viewOffer(
                            entity: ViewOfferEntity(
                              offerId: s.id ?? "",
                            ),
                          );
                        },
                      ),
                      CustomSpacers.height20,
                    ]
                  ],
                ),
              );
            }

            if (allOffers.isEmpty) {
              return const Center(
                child: Text('No offers found'),
              );
            }

            return const Loading();
          },
        ),
      ),
    );
  }

  Future<void> _showCategoryBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to expand to full screen
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: true,
          initialChildSize: 1.0, // Full-screen from the start
          maxChildSize: 1.0, // Maximum height is full-screen
          minChildSize: 1.0, // Minimum height is also full-screen
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center items vertically
                children: [
                  CustomSpacers.height38,
                  Text(
                    'Filter business based on categories',
                    style: AppTextThemes.theme(context).displayLarge?.copyWith(
                        // color: ColorPalette.primaryColor,
                        ),
                  ),
                  CustomSpacers.height16,
                  CategoryFilterWidget(
                    isOffersSheet: true,
                    onResetFilterTap: () {
                      Navigator.pop(context);
                      _offersCubit.resetCategoryFilters();
                      _businessCategoryCubit.resetCategories();
                    },
                    businessCategoryCubit: _businessCategoryCubit,
                    onItemPressed: (categoryId2, categoryId3, categoryId4) {},
                    onApplyFilterTap: () {
                      Navigator.pop(context);
                      _offersCubit.getAllBOffers();
                    },
                  ),
                  CustomSpacers.height56,
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showStateBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to expand to full screen
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: true,

          initialChildSize: 1.0, // Full-screen from the start
          maxChildSize: 1.0, // Maximum height is full-screen
          minChildSize: 1.0, // Minimum height is also full-screen
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: ColorPalette.scaffoldBackgroundColor,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center items vertically
                  children: [
                    CustomSpacers.height38,
                    Text(
                      'Filter business based on locations',
                      style:
                          AppTextThemes.theme(context).displayLarge?.copyWith(),
                    ),
                    CustomSpacers.height16,
                    StateFilterWidget(
                      onResetTap: () {
                        Navigator.pop(context);
                        _selectorCubit.resetSelections();
                        _offersCubit.resetStateFilters();
                      },
                      stateSelectorCubit: _selectorCubit,
                      onFilterTap: () {
                        Navigator.pop(context);
                        _offersCubit.getAllBOffers();
                      },
                      onItemPressed: (id) {},
                    ),
                    CustomSpacers.height56,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
