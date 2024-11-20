import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/datasources/local/business_directory_local_data_sources.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/datasources/remote/business_directory_remote_data_sources.dart';
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
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';

class BusinessDirectoryRepositoryImpl implements BusinessDirectoryRepository {
  final BusinessDirectoryRemoteDataSources _businessDirectoryRemoteDataSources;
  final BusinessDirectoryLocalDataSources _businessDirectoryLocalDataSources;

  final NetworkInfo _networkInfo;

  BusinessDirectoryRepositoryImpl(
      {required BusinessDirectoryRemoteDataSources
          businessDirectoryRemoteDataSources,
      required BusinessDirectoryLocalDataSources
          businessDirectoryLocalDataSources,
      required NetworkInfo networkInfo})
      : _businessDirectoryRemoteDataSources =
            businessDirectoryRemoteDataSources,
        _networkInfo = networkInfo,
        _businessDirectoryLocalDataSources = businessDirectoryLocalDataSources;

  @override
  Future<Either<Failure, ApiBaseResponse<List<StateModel>>>> fetchAllTheStates({
    required ShouldFetchStatesAgain shouldFetchAgain,
  }) async {
    bool shouldFetchStatesAgain = shouldFetchAgain.value;

    // Check if states exist in local DB only if we don't need to refetch
    if (!shouldFetchStatesAgain &&
        await _businessDirectoryLocalDataSources.checkIfStatesExists()) {
      final data =
          await _businessDirectoryLocalDataSources.getStatesFromLocalDb();
      return Right(
        ApiBaseResponse(
          data: data.states,
          success: true,
          message: "Data Retrieved Successfully",
        ),
      );
    }

    try {
      // Fetch from the API if the network is connected
      if (await _networkInfo.isConnected) {
        final res =
            await _businessDirectoryRemoteDataSources.fetchAllTheStates();

        // Save the states to the local DB
        await _businessDirectoryLocalDataSources
            .saveStatesToLocalDb(StateModelResponse(states: res.data!));

        return Right(res);
      } else {
        // Handle no internet connection
        return Left(InternetFailure());
      }
    } catch (e) {
      // Handle any API or other errors
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse>> createBusiness(
      {required BusinessEntity data}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.createBusiness(
            data: data);

        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<BusinessOfferResponseModel>>>
      fetchAllTheBusinesses({required GetAllBusinessEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources
            .fetchAllTheBusinesses(entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse>> updateBusiness(
      {required BusinessEntity data}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.updateBusiness(
            data: data);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<List<CategoryModel>>>> getCategories(
      {required CategoryEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res =
            await _businessDirectoryRemoteDataSources.getCatergories(entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<List<ProductModel>>>> getProducts(
      {required GetProductsEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res =
            await _businessDirectoryRemoteDataSources.getProducts(entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<List<BusinessModel>>>>
      fetchMyBusiness() async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.fetchMyBusiness();
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse>> verifyBusiness(
      {required VerifyBusinessEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.verifyBusiness(
            data: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse>> rateBusiness(
      {required RateBusinessEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.rateBusiness(
            data: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse>> shareBusiness(
      {required ShareBusinessEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.shareBusiness(
            data: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> addBusinessToFavorite(
      {required AddBusinessToFavouriteEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources
            .addToFavoriteBusiness(data: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> deleteMyBusiness({
    required String businessId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _businessDirectoryRemoteDataSources.deleteMyBusiness(
          businessId: businessId,
        );
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
