import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class CreateOfferUseCase
    implements UseCase<ApiBaseResponseNoData, CreateOfferEntity> {
  final OfferRemoteRepository _offerRemoteRepository;

  CreateOfferUseCase({
    required OfferRemoteRepository offerRemoteRepository,
  }) : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      CreateOfferEntity entity) {
    return _offerRemoteRepository.createOffer(entity: entity);
  }
}
