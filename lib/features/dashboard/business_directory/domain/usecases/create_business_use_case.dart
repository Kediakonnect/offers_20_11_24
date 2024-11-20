import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class CreateBusinessUseCase
    implements UseCase<ApiBaseResponse, BusinessEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  CreateBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse>> call(BusinessEntity entity) {
    return _businessDirectoryRepository.createBusiness(data: entity);
  }
}
