import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/wallet_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';

class GetUserWalletBalanceUseCase
    implements UseCase<ApiBaseResponse<WalletModel>, NoParams> {
  final OfferRemoteRepository _offerRemoteRepository;

  GetUserWalletBalanceUseCase({
    required OfferRemoteRepository offerRemoteRepository,
  }) : _offerRemoteRepository = offerRemoteRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<WalletModel>>> call(NoParams params) {
    return _offerRemoteRepository.getUserWalletBalance();
  }
}
