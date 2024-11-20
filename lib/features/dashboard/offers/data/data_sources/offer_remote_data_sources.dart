import 'package:divyam_flutter/core/api/custom_client.dart';
import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/wallet_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/add_offer_to_favorite_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_all_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_my_offers_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/get_offer_by_id_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/view_offer_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:flutter/material.dart';

class OfferRemoteDataSource {
  final CustomHttpClient _client = CustomHttpClient();
  Future<ApiBaseResponse<List<OfferModel>>> getAllOffers(
      GetAllOffersEntity entity) async {
    try {
      final res = await _client.get(
          url: getOffersUrl, queryParams: entity.toQueryParameters());

      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => ((json as Map<String, dynamic>)['data']['offers']).isEmpty
              ? <OfferModel>[]
              : (json['data']['offers'] as List<dynamic>)
                  .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<OfferModel>> getOffersById(
      {required GetOfferByIdEntity entity}) async {
    try {
      final res = await _client.get(url: '$getOfferById/${entity.id}');

      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => OfferModel.fromJson(
            (json as Map<String, dynamic>)['data']['offer'],
          ),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<List<OfferModel>>> getMyOffers(
      {required GetMyOffersEntity entity}) async {
    try {
      final res =
          await _client.get(url: getMyOffersUrl, queryParams: entity.toJson());

      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => ((json as Map<String, dynamic>)['data']['offers']).isEmpty
              ? <OfferModel>[]
              : (json['data']['offers'] as List<dynamic>)
                  .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponseNoData> createOffer(
      {required CreateOfferEntity entity}) async {
    try {
      final formData = await entity.toFormData();

      String url = createOfferUrl;

      if (entity.offerFormType == CreateOfferType.updateOffer) {
        url = '$updateOfferUrl/${entity.offerId}';
        // formData.fields.add(
        //   const MapEntry(
        //     '_method',
        //     'patch',
        //   ),
        // );
      }

      debugPrint(formData.toString());

      final res = await _client.createMultipartRequest(
        formData: formData,
        url: url,
      );
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponseNoData.fromJson(decoded);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponseNoData> viewOffer(
      {required ViewOfferEntity entity}) async {
    try {
      final res = await _client.post(
        url: viewOfferUrl,
        bodyData: entity.toJson(),
      );

      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponseNoData.fromJson(decoded);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponseNoData> performSocialAction(
      {required OfferSocialEntity data}) async {
    try {
      final res = await _client.post(url: data.url, bodyData: data);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponseNoData.fromJson(decoded);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<WalletModel>> getUserWalletBalance() async {
    try {
      final res = await _client.get(url: getUserWalletBalanceUrl);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => WalletModel.fromJson(
            (json as Map<String, dynamic>)['data'],
          ),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponseNoData> deleteOffer({required String offerId}) async {
    try {
      final res = await _client.delete(url: '$deleteOfferUrl/$offerId');

      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponseNoData.fromJson(decoded);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
