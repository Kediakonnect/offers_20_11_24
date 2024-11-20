import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/widgets/offer_card_secondary.dart';
import 'package:divyam_flutter/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteOffersTab extends StatefulWidget {
  final FavouriteCubit favouriteCubit;
  const FavouriteOffersTab({
    super.key,
    required this.favouriteCubit,
  });

  @override
  State<FavouriteOffersTab> createState() => _FavouriteOffersTabState();
}

class _FavouriteOffersTabState extends State<FavouriteOffersTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.favouriteCubit.fetchFavouritesOffers();
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
        if (state is FavouriteOffersLoaded) {
          return _buildAllBuisnessList(state.offers, context);
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }

  Widget _buildAllBuisnessList(List<OfferModel> data, BuildContext context) {
    if (data.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h),
        child: Text(
          'No Offers Added to Favourites',
          style: AppTextThemes.theme(context).headlineLarge,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var offer in data) ...[
          OfferCardSecondary(
            onTap: () {},
            onDislikeTapped: () {},
            onFavoriteTapped: () {},
            onLikeTapped: () {},
            onShareTapped: () {},
            offerModel: offer,
          ),
          CustomSpacers.height26,
        ],
      ],
    );
  }
}
