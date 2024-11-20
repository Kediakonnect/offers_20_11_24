import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_offer_response_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_all_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class GetAllBusinessUseCase
    implements
        UseCase<ApiBaseResponse<BusinessOfferResponseModel>,
            GetAllBusinessEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  GetAllBusinessUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<BusinessOfferResponseModel>>> call(
      GetAllBusinessEntity entity) {
    return _businessDirectoryRepository.fetchAllTheBusinesses(entity: entity);
  }
}
