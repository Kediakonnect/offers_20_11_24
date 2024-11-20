import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class VerifyBusinessUseCase
    implements UseCase<ApiBaseResponse, VerifyBusinessEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  VerifyBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse>> call(VerifyBusinessEntity entity) {
    return _businessDirectoryRepository.verifyBusiness(entity: entity);
  }
}
