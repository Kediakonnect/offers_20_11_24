import 'package:divyam_flutter/core/api/custom_client.dart';
import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';

class FavouritesRemoteDataSources {
  final CustomHttpClient _client = CustomHttpClient();
  Future<ApiBaseResponse<List<BusinessModel>>> fetchFavouriteBusiness() async {
    try {
      final response = await _client.get(url: '$getAllFavourite?type=Business');

      final decoded = response.data;

      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
            decoded,
            (json) => ((json as Map)['data']['offers'] as List)
                .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
                .toList());
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<List<OfferModel>>> fetchFavouriteOffers() async {
    try {
      final response = await _client.get(url: '$getAllFavourite?type=Offer');

      final decoded = response.data;

      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
            decoded,
            (json) => ((json as Map)['data']['offers'] as List)
                .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
                .toList());
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
