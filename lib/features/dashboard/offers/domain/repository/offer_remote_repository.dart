import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/wallet_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_all_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_my_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';

abstract class OfferRemoteRepository {
  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> getAllOffers(
      GetAllOffersEntity entity);

  Future<Either<Failure, ApiBaseResponse<List<OfferModel>>>> getMyOffers(
      {required GetMyOffersEntity entity});

  Future<Either<Failure, ApiBaseResponse<OfferModel>>> getOfferById(
      {required GetOfferByIdEntity entity});

  Future<Either<Failure, ApiBaseResponseNoData>> createOffer({
    required CreateOfferEntity entity,
  });

  Future<Either<Failure, ApiBaseResponseNoData>> viewOffer({
    required ViewOfferEntity entity,
  });

  Future<Either<Failure, ApiBaseResponseNoData>> addOfferToFavorite({
    required OfferSocialEntity entity,
  });

  Future<Either<Failure, ApiBaseResponse<WalletModel>>> getUserWalletBalance();

  Future<Either<Failure, ApiBaseResponseNoData>> deleteMyOffer({
    required String offerId, // Accept offer ID to delete
  });
}
