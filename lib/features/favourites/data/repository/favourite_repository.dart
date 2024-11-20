import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/favourites/data/data_sources/favourite_data_sources.dart';

class FavouritesRepository {
  final FavouritesRemoteDataSources _remoteDataSource;
  final NetworkInfo _networkInfo;

  FavouritesRepository({
    required FavouritesRemoteDataSources remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  Future<Either<Failure, ApiBaseResponse<List<BusinessModel>>>>
      fetchFavouriteBusinesses() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.fetchFavouriteBusiness();
        return Right(response);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>>
      fetchFavouriteOffers() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.fetchFavouriteOffers();
        return Right(response);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
