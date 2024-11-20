import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class GetOfferByIdUseCase
    implements UseCase<ApiBaseResponse<OfferModel>, GetOfferByIdEntity> {
  final OfferRemoteRepository _offerRemoteRepository;

  GetOfferByIdUseCase({
    required OfferRemoteRepository offerRemoteRepository,
  }) : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<OfferModel>>> call(
      GetOfferByIdEntity entity) {
    return _offerRemoteRepository.getOfferById(entity: entity);
  }
}
