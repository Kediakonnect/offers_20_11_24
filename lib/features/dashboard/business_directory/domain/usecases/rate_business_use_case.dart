import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class RateBusinessUseCase
    implements UseCase<ApiBaseResponse, RateBusinessEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  RateBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse>> call(RateBusinessEntity entity) {
    return _businessDirectoryRepository.rateBusiness(entity: entity);
  }
}
