import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class GetMyBusinessUseCase
    implements UseCase<ApiBaseResponse<List<BusinessModel>>, NoParams> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  GetMyBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<BusinessModel>>>> call(
      NoParams entity) {
    return _businessDirectoryRepository.fetchMyBusiness();
  }
}
