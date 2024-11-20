import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/favourites/data/repository/favourite_repository.dart';

class FetchFavouriteOffersUseCase
    implements UseCase<ApiBaseResponse<List<OfferModel>>, NoParams> {
  final FavouritesRepository _favouritesRepository;

  FetchFavouriteOffersUseCase({
    required FavouritesRepository favouritesRepository,
  }) : _favouritesRepository = favouritesRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> call(
      NoParams params) {
    return _favouritesRepository.fetchFavouriteOffers();
  }
}
