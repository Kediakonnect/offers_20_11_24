import 'package:bloc/bloc.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/favourites/domain/use_cases/get_all_favourite_business_use_case.dart';
import 'package:divyam_flutter/features/favourites/domain/use_cases/get_all_favourite_offers.dart';
import 'package:equatable/equatable.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FetchFavouriteBusinessUseCase fetchFavouriteBusinessUseCase;
  final FetchFavouriteOffersUseCase fetchFavouriteOffersUseCase;

  FavouriteCubit({
    required this.fetchFavouriteBusinessUseCase,
    required this.fetchFavouriteOffersUseCase,
  }) : super(FavouriteInitial());

  Future<void> fetchFavouritesBusinesses(
      {bool? isOptimisticUpdate = false}) async {
    if (!isOptimisticUpdate!) {
      emit(FavouriteLoading());
    } else {
      emit(OptimisticState());
    }

    final result = await fetchFavouriteBusinessUseCase(NoParams());
    result.fold(
      (failure) {
        emit(
          FavouriteError(
            message: _mapFailureToMessage(failure),
          ),
        );
      },
      (response) {
        emit(
          FavouriteBusinessLoaded(
            businesses: response.data ?? [],
          ),
        );
      },
    );
  }

  Future<void> fetchFavouritesOffers() async {
    emit(FavouriteLoading());

    final result = await fetchFavouriteOffersUseCase(NoParams());

    result.fold(
      (failure) => emit(FavouriteError(message: _mapFailureToMessage(failure))),
      (response) => emit(FavouriteOffersLoaded(offers: response.data ?? [])),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // You can customize error messages here based on the type of failure
    if (failure is InternetFailure) {
      return 'No internet connection';
    } else if (failure is ApiFailure) {
      return failure.message ?? 'Something went wrong';
    } else {
      return 'Unexpected error';
    }
  }
}
