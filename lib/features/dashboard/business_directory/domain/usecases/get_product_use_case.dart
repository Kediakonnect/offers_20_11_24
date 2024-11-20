import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/product_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_products_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class GetProductUseCase
    implements UseCase<ApiBaseResponse<List<ProductModel>>, GetProductsEntity> {
  final BusinessDirectoryRepository _businessDirectoryRepository;

  GetProductUseCase({
    required BusinessDirectoryRepository businessDirectoryRepository,
  }) : _businessDirectoryRepository = businessDirectoryRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<List<ProductModel>>>> call(
      GetProductsEntity entity) {
    return _businessDirectoryRepository.getProducts(entity: entity);
  }
}
