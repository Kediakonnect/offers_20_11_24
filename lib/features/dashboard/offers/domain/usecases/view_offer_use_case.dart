import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class ViewOfferUseCase
    implements UseCase<ApiBaseResponseNoData, ViewOfferEntity> {
  final OfferRemoteRepository _offerRemoteRepository;

  ViewOfferUseCase({required OfferRemoteRepository offerRemoteRepository})
      : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      ViewOfferEntity params) async {
    return await _offerRemoteRepository.viewOffer(entity: params);
  }
}
