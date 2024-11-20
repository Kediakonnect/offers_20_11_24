import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/should_fetch_states_again.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class GetStatesUseCase
    implements
        UseCase<ApiBaseResponse<List<StateModel>>, ShouldFetchStatesAgain> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  GetStatesUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<StateModel>>>> call(
      ShouldFetchStatesAgain shouldFetchAgain) {
    return _businessDirectoryRepository.fetchAllTheStates(
        shouldFetchAgain: shouldFetchAgain);
  }
}
