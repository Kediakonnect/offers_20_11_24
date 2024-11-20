import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/share_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/market_card.dart';
import 'package:divyam_flutter/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class FavouriteBusinessTab extends StatefulWidget {
  final FavouriteCubit favouriteCubit;
  final BusinessDirectoryCubit businessDirectoryCubit;
  const FavouriteBusinessTab(
      {super.key,
      required this.favouriteCubit,
      required this.businessDirectoryCubit});

  @override
  State<FavouriteBusinessTab> createState() => _FavouriteBusinessTabState();
}

class _FavouriteBusinessTabState extends State<FavouriteBusinessTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.favouriteCubit.fetchFavouritesBusinesses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      bloc: widget.favouriteCubit,
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FavouriteBusinessLoaded) {
          return _buildAllBuisnessList(state.businesses, context);
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }

  Widget _buildAllBuisnessList(List<BusinessModel> data, BuildContext context) {
    if (data.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h),
        child: Text(
          'No Business Added to Favourites',
          style: AppTextThemes.theme(context).headlineLarge,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var business in data) ...[
          MarketCard(
            onShareTaped: () {
              shareBusiness(business.toEntity());
            },
            onFavoriteTapped: () {
              widget.businessDirectoryCubit.addBusinessToFavorite(
                AddBusinessToFavouriteEntity(
                    businessId: business.id,
                    status: business.isFavourite ? '0' : "1"),
              );
            },
            onRate: (entity) {
              // _businessDirectoryCubit.rateBusiness(entity);
            },
            onTap: () => CustomNavigator.pushTo(
              context,
              AppRouter.businessDetailScreen,
              arguments: business.toEntity(),
            ),
            businessEntity: business.toEntity(),
          ),
          CustomSpacers.height26,
        ],
      ],
    );
  }

  Future shareBusiness(BusinessEntity? entity) async {
    await Share.share(
      'Checkout my Business ${entity?.name ?? "Business Name"} on Divyam',
      subject: entity?.name ?? "Business Name",
    );

    widget.businessDirectoryCubit.shareBusiness(
      ShareBusinessEntity(
        businessId: entity?.businessId ?? "",
        status: "1",
      ),
    );
  }
}
