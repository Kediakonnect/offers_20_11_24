import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_all_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class GetAllOffersUseCase
    implements UseCase<ApiBaseResponse<List<OfferModel>>, GetAllOffersEntity> {
  final OfferRemoteRepository _offerRemoteRepository;

  GetAllOffersUseCase({required OfferRemoteRepository offerRemoteRepository})
      : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> call(
      GetAllOffersEntity params) async {
    return await _offerRemoteRepository.getAllOffers(params);
  }
}