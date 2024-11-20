import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_offer_response_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/product_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/add_business_to_favourite_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_all_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_products_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/rate_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/share_business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/should_fetch_states_again.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';

abstract class BusinessDirectoryRepository {
  Future<Either<Failure, ApiBaseResponse<List<StateModel>>>> fetchAllTheStates(
      {required ShouldFetchStatesAgain shouldFetchAgain});
  Future<Either<Failure, ApiBaseResponse>> createBusiness(
      {required BusinessEntity data});
  Future<Either<Failure, ApiBaseResponse>> updateBusiness(
      {required BusinessEntity data});

  Future<Either<Failure, ApiBaseResponse<BusinessOfferResponseModel>>>
      fetchAllTheBusinesses({required GetAllBusinessEntity entity});
  Future<Either<Failure, ApiBaseResponse<List<CategoryModel>>>> getCategories(
      {required CategoryEntity entity});

  Future<Either<Failure, ApiBaseResponse<List<ProductModel>>>> getProducts(
      {required GetProductsEntity entity});

  Future<Either<Failure, ApiBaseResponse<List<BusinessModel>>>>
      fetchMyBusiness();

  Future<Either<Failure, ApiBaseResponse>> verifyBusiness(
      {required VerifyBusinessEntity entity});

  Future<Either<Failure, ApiBaseResponse>> rateBusiness(
      {required RateBusinessEntity entity});

  Future<Either<Failure, ApiBaseResponse>> shareBusiness(
      {required ShareBusinessEntity entity});

  Future<Either<Failure, ApiBaseResponseNoData>> addBusinessToFavorite(
      {required AddBusinessToFavouriteEntity entity});

  Future<Either<Failure, ApiBaseResponseNoData>> deleteMyBusiness(
      {required String businessId}); // Added deleteMyBusiness
}
