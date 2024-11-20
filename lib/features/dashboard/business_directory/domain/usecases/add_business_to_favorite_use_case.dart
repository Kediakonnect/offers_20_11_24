import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class AddBusinessToFavoriteUseCase
    implements UseCase<ApiBaseResponseNoData, AddBusinessToFavouriteEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  AddBusinessToFavoriteUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      AddBusinessToFavouriteEntity entity) {
    return _businessDirectoryRepository.addBusinessToFavorite(entity: entity);
  }
}
