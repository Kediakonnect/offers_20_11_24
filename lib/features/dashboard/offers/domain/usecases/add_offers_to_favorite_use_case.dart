import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class AddOffersToFavouriteUseCase
    implements UseCase<ApiBaseResponseNoData, OfferSocialEntity> {
  final OfferRemoteRepository _offerRemoteRepository;

  AddOffersToFavouriteUseCase({
    required OfferRemoteRepository offerRemoteRepository,
  }) : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      OfferSocialEntity entity) {
    return _offerRemoteRepository.addOfferToFavorite(entity: entity);
  }
}
