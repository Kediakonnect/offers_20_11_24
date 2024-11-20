import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class DeleteMyBusinessUseCase
    implements UseCase<ApiBaseResponseNoData, String> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  DeleteMyBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(String businessId) {
    return _businessDirectoryRepository.deleteMyBusiness(
        businessId: businessId);
  }
}
