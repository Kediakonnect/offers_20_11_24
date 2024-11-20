import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class GetCategoriesUseCase
    implements UseCase<ApiBaseResponse<List<CategoryModel>>, CategoryEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  GetCategoriesUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<CategoryModel>>>> call(
      CategoryEntity entity) {
    return _businessDirectoryRepository.getCategories(entity: entity);
  }
}
