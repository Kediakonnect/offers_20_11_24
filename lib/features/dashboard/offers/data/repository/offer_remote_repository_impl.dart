import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/data_sources/offer_remote_data_sources.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/wallet_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_all_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_my_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';
import 'package:flutter/material.dart';

class OfferRemoteRepositoryImpl implements OfferRemoteRepository {
  final OfferRemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;

  OfferRemoteRepositoryImpl({
    required OfferRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> getAllOffers(
      GetAllOffersEntity entity) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.getAllOffers(entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> createOffer(
      {required CreateOfferEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        debugPrint(entity.toString());
        final res = await _remoteDataSource.createOffer(entity: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> getMyOffers(
      {required GetMyOffersEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.getMyOffers(entity: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> viewOffer(
      {required ViewOfferEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.viewOffer(entity: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> addOfferToFavorite(
      {required OfferSocialEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.performSocialAction(data: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<OfferModel>>> getOfferById(
      {required GetOfferByIdEntity entity}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.getOffersById(entity: entity);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<WalletModel>>>
      getUserWalletBalance() async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.getUserWalletBalance();
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> deleteMyOffer(
      {required String offerId}) async {
    try {
      if (await _networkInfo.isConnected) {
        final res = await _remoteDataSource.deleteOffer(offerId: offerId);
        return Right(res);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
