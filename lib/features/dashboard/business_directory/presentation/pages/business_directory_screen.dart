import 'package:cached_network_image/cached_network_image.dart';
import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_offer_list_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_all_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/share_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/category_filter_widget.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/dash_grid_view.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/market_card.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/state_filter_widget.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/dash_board_action_btns.dart';
import 'package:divyam_flutter/ui/moleclues/disabled_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/helpers/scaffold_helpers.dart';

class BusinessDirectoryScreen extends StatefulWidget {
  const BusinessDirectoryScreen({super.key});

  @override
  State<BusinessDirectoryScreen> createState() =>
      _BusinessDirectoryScreenState();
}

class _BusinessDirectoryScreenState extends State<BusinessDirectoryScreen> {
  late BusinessDirectoryCubit _businessDirectoryCubit;
  late BusinessCategoryCubit _businessCategoryCubit;
  late StateSelectorCubit _selectorCubit;
  BusinessOfferListEntity allBusinesses =
      BusinessOfferListEntity(businesses: [], offers: []);

  GetAllBusinessEntity _entity = GetAllBusinessEntity();

  @override
  void initState() {
    _businessDirectoryCubit = sl<BusinessDirectoryCubit>();
    _businessCategoryCubit = sl<BusinessCategoryCubit>();
    _selectorCubit = sl<StateSelectorCubit>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _businessDirectoryCubit.getAllBusiness(GetAllBusinessEntity());
      _selectorCubit.getStates();
    });
    super.initState();
  }

  @override
  void dispose() {
    // _businessDirectoryCubit.close();
    // _selectorCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        CustomNavigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.addsScreen,
          arguments: OfferType.exit.value,
        );
      },
      child: CustomScaffold(
        enableBottomSheet: true,
        floatingActionButton: DashBoardActionButtons(
          onAddPressed: () => CustomNavigator.pushTo(
            context,
            AppRouter.myBusinessScreen,
          ),
          onMlmPressed: () {},
        ),
        appBarTitle: 'Business Directory'.toUpperCase(),
        body: BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
          bloc: _businessDirectoryCubit,
          buildWhen: (previous, current) =>
              current is! OptimisticState && allBusinesses.businesses.isEmpty,
          listener: (context, state) {
            if (state is RateBusinessSuccessState) {
              _businessDirectoryCubit.refetch();
            }
            if (state is AddBusinessToFavoriteSuccessState) {
              _businessDirectoryCubit.refetch();
            }
            if (state is BusinessDirectoryFailure) {
              ScaffoldHelper.showFailureSnackBar(
                  context: context, message: state.message);
            }

            if (state is GetAllBusinessSuccessState) {
              allBusinesses = state.data;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        DashBoardGridView(
                          key: _businessCategoryCubit.category1 == null &&
                                  state is! RateBusinessSuccessState
                              ? GlobalKey()
                              : null,
                          onItemPressed: (id) {
                            _entity = _entity.copyWith(level1Id: id);
                            _businessDirectoryCubit.getAllBusiness(_entity);

                            _businessDirectoryCubit.getAllBusiness(_entity);
                          },
                          businessCategoryCubit: _businessCategoryCubit,
                        ),
                        CustomSpacers.height26,
                        Row(
                          children: [
                            DisabledDropDown(
                              onTap: () => _showCategoryBottomSheet(),
                              hintText: 'Select Category',
                            ),
                            const Spacer(),
                            _buildStateDropDown(
                                ontap: () => _showStateBottomSheet()),
                          ],
                        ),
                        CustomSpacers.height26,
                      ],
                    ),
                  ),
                  _buildBusinessList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStateDropDown({required VoidCallback ontap}) {
    return BlocBuilder<StateSelectorCubit, StateSelectorState>(
      bloc: _selectorCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              SizedBox(
                width: 90.w,
                child: NeuroMorphicText(
                  text: _selectorCubit.selectedTaluka?.name ?? "Location",
                  fontSize: 14,
                ),
              ),
              CustomSpacers.width10,
              const Icon(
                Icons.arrow_drop_down,
                color: ColorPalette.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBusinessList() {
    return BlocBuilder<BusinessDirectoryCubit, BusinessDirectoryState>(
      bloc: _businessDirectoryCubit,
      buildWhen: (previous, current) => current is! OptimisticState,
      builder: (context, state) {
        if (state is GetAllBusinessDirectoryFailure) {
          return const Center(child: Text('Something went wrong 😕'));
        }

        if (allBusinesses.businesses.isNotEmpty) {
          return _buildAllBuisnessList(allBusinesses);
        }

        return const Loading();
      },
    );
  }

  Widget _buildAllBuisnessList(BusinessOfferListEntity data) {
    if (data.businesses.isEmpty && data.offers.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
        child: Text(
          'No Business Found ☹️',
          style: AppTextThemes.theme(context).headlineLarge,
        ),
      );
    }

    return Column(
      children: [
        _buildList(data.businesses, data.offers),
      ],
    );
  }

  _buildList(List<BusinessModel> data, List<OfferModel> offers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            children: [
              for (int i = 0; i < data.length; i++) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: MarketCard(
                    onShareTaped: () {
                      shareBusiness(data[i].toEntity());
                    },
                    onVerifyTapped: () {
                      _businessDirectoryCubit
                          .verifyBusiness(VerifyBusinessEntity(
                        businessId: data[i].id ?? "",
                      ));
                    },
                    onFavoriteTapped: () {
                      _businessDirectoryCubit.addBusinessToFavorite(
                        AddBusinessToFavouriteEntity(
                          businessId: data[i].id,
                          status: data[i].isFavourite ? '0' : "1",
                        ),
                      );
                    },
                    onRate: (entity) {
                      _businessDirectoryCubit.rateBusiness(entity);
                    },
                    onTap: () => CustomNavigator.pushTo(
                      context,
                      AppRouter.businessDetailScreen,
                      arguments: data[i].toEntity(),
                    ),
                    businessEntity: data[i].toEntity(),
                  ),
                ),
                CustomSpacers.height26,

                // Insert an offer after every 3 businesses
                if ((i + 1) % 3 == 0 && (i ~/ 3) < offers.length) ...[
                  Visibility(
                    visible: offers[i ~/ 3].image != null,
                    child: Column(children: [
                      InkWell(
                        onTap: () => CustomNavigator.pushTo(
                          context,
                          AppRouter.offerDetailScreen,
                          arguments: offers[i ~/ 3],
                        ),
                        child: SizedBox(
                          height: 97.h,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: offers[i ~/ 3].image ?? "",
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      CustomSpacers.height26,
                    ]),
                  )
                ],
              ],
            ],
          ),
        ),
      ],
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
                    onResetFilterTap: () {
                      Navigator.pop(context);
                      String? city = _entity.city;
                      _entity = GetAllBusinessEntity(
                        city: city,
                      );
                      _businessDirectoryCubit.getAllBusiness(_entity);
                      _businessCategoryCubit.resetCategories();
                    },
                    onApplyFilterTap: () {
                      Navigator.pop(context);
                      _businessDirectoryCubit.getAllBusiness(_entity);
                    },
                    businessCategoryCubit: _businessCategoryCubit,
                    onItemPressed: (categoryId2, categoryId3, categoryId4) {
                      if (categoryId2 != null) {
                        _entity = _entity.copyWith(level2Id: categoryId2);
                      }

                      // if (categoryId3 != null) {
                      //   _entity = _entity.copyWith(
                      //     level3Id: categoryId3,
                      //   );
                      // }
                      // if (categoryId4 != null) {
                      //   _entity = _entity.copyWith(
                      //     level4Id: categoryId4,
                      //   );
                      // }
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
                          AppTextThemes.theme(context).displayLarge?.copyWith(
                              // color: ColorPalette.primaryColor,
                              ),
                    ),
                    CustomSpacers.height16,
                    StateFilterWidget(
                      onResetTap: () {
                        Navigator.pop(context);
                        _selectorCubit.resetSelections();
                        GetAllBusinessEntity temp = _entity;
                        _entity = GetAllBusinessEntity(
                          level1Id: temp.level1Id,
                          level2Id: temp.level2Id,
                          level3Id: temp.level3Id,
                          level4Id: temp.level4Id,
                        );
                        _businessDirectoryCubit.getAllBusiness(_entity);
                      },
                      stateSelectorCubit: _selectorCubit,
                      onFilterTap: () {
                        Navigator.pop(context);
                        _businessDirectoryCubit.getAllBusiness(_entity);
                      },
                      onItemPressed: (id) {
                        _entity = _entity.copyWith(city: id);
                      },
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


/**
 * BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
        bloc: _businessDirectoryCubit,
        listener: (context, state) {
          if (state is BusinessDirectoryFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is GetAllBusinessSuccessState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CustomSpacers.height26,
                  Wrap(
                    spacing: 20.w,
                    runSpacing: 20.h,
                    children: [
                      for (var business in state.data) ...[
                        BusinessCard(
                          status: BusinessStatusType.live,
                          onTap: () {},
                          data: business,
                        ),
                      ]
                    ],
                  )
                ],
              ),
            );
          }

          return const Loading();
        },
      ),
 */