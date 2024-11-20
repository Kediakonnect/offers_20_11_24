import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class DeleteOfferUseCase implements UseCase<ApiBaseResponseNoData, String> {
  final OfferRemoteRepository repository;

  DeleteOfferUseCase({required this.repository});

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(String offerId) {
    return repository.deleteMyOffer(offerId: offerId);
  }
}
