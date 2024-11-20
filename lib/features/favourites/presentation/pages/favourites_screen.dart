import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:divyam_flutter/features/favourites/presentation/widgets/favourite_business_tab.dart';
import 'package:divyam_flutter/features/favourites/presentation/widgets/favourite_offers_tab.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late BusinessDirectoryCubit _businessDirectoryCubit;
  late FavouriteCubit _favouriteCubit;

  int _tab = 0;

  @override
  void initState() {
    _businessDirectoryCubit = sl<BusinessDirectoryCubit>();
    _favouriteCubit = sl<FavouriteCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "FAVOURITES",
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavouriteCubit, FavouriteState>(
            bloc: _favouriteCubit,
            listener: (context, state) {
              if (state is FavouriteError) {
                ScaffoldHelper.showFailureSnackBar(
                  context: context,
                  message: state.message,
                );
              }
            },
          ),
          BlocListener<BusinessDirectoryCubit, BusinessDirectoryState>(
            bloc: _businessDirectoryCubit,
            listener: (context, state) {
              if (state is RateBusinessSuccessState) {
                _favouriteCubit.fetchFavouritesBusinesses(
                    isOptimisticUpdate: true);
              }
              if (state is AddBusinessToFavoriteSuccessState) {
                _favouriteCubit.fetchFavouritesBusinesses(
                    isOptimisticUpdate: true);
              }
            },
          ),
        ],
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          bloc: _favouriteCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: [
                  CustomTabWidget(
                    tabWidth: double.infinity,
                    onValueChange: (v) {
                      setState(() {
                        _tab = v;
                      });
                    },
                    options: const {"BUSINESS", "OFFERS", "EVENTS", "ANN's"},
                    optionWidth: 65.w,
                    borderRadius: 10.r,
                  ),
                  CustomSpacers.height20,
                  _getTabContent(_tab),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getTabContent(int index) {
    switch (index) {
      case 0:
        return FavouriteBusinessTab(
          favouriteCubit: _favouriteCubit,
          businessDirectoryCubit: _businessDirectoryCubit,
        );
      case 1:
        return FavouriteOffersTab(
          favouriteCubit: _favouriteCubit,
        );
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
