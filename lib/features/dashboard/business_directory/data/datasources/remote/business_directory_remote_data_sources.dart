import 'package:dio/dio.dart';
import 'package:divyam_flutter/core/api/custom_client.dart';
import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/error/exception.dart';
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
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/verify_business_entity.dart';
import 'package:flutter/foundation.dart';

class BusinessDirectoryRemoteDataSources {
  final CustomHttpClient _client = CustomHttpClient();

  Future<ApiBaseResponse<List<StateModel>>> fetchAllTheStates() async {
    try {
      final response = await _client.get(url: GET_ALL_STATES_URL);
      final decoded = response.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => ((json as Map<String, dynamic>)['data'] as List<dynamic>)
              .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
              .toSet()
              .toList(),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<List<CategoryModel>>> getCatergories(
      CategoryEntity entity) async {
    try {
      final response = await _client.get(url: entity.url);
      final decoded = response.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
            decoded,
            (json) => ((json as Map)['data'] as List)
                .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
                .toSet()
                .toList());
      }
    } catch (e) {
      debugPrint(e.toString());

      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<List<ProductModel>>> getProducts(
      GetProductsEntity entity) async {
    try {
      final response = await _client.get(
          url: getAllProductsUrl, queryParams: entity.toJson());
      final decoded = response.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
            decoded,
            (json) => ((json as Map)['data'] as List)
                .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
                .toSet()
                .toList());
      }
    } catch (e) {
      debugPrint(e.toString());

      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse> createBusiness({required BusinessEntity data}) async {
    try {
      final formData = await data.toFormData();

      // Removing _method field if exists (for creating new entry)
      formData.fields.removeWhere((element) => element.key == '_method');

      debugPrint(formData.toString());
      // Make the multipart request to create a business
      final res = await _client.createMultipartRequest(
        formData: formData,
        url: createBusinessUrl,
      );

      debugPrint(res.data.toString());
      final decoded = res.data;

      // Check if the response indicates a failure
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(decoded, (json) => json);
      }
    } catch (e) {
      // Improve error message handling
      if (e is ApiException) {
        // ApiException with a message from the server
        throw ApiException(message: e.message);
      } else if (e is DioError) {
        // Handle Dio-specific errors
        if (e.response != null && e.response!.data != null) {
          // Parse the error message from Dio's response data
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        } else {
          // Network error or some other issue without a proper response
          throw ApiException(message: e.message ?? 'An error occurred');
        }
      } else {
        // Handle other types of exceptions
        throw ApiException(message: e.toString());
      }
    }
  }

  Future<ApiBaseResponse> updateBusiness({required BusinessEntity data}) async {
    try {
      debugPrint(data.toFormData().toString());
      final String url = '$updateBusinessUrl/${data.businessId}';
      final res = await _client.createMultipartRequest(
          formData: await data.toFormData(), url: url);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(decoded, (json) => json);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<BusinessOfferResponseModel>> fetchAllTheBusinesses(
      GetAllBusinessEntity entity) async {
    try {
      final response = await _client.get(url: entity.url);
      final decoded = response.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(
            decoded,
            (v) =>
                BusinessOfferResponseModel.fromJson(v as Map<String, dynamic>));
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse<List<BusinessModel>>> fetchMyBusiness() async {
    try {
      final response = await _client.get(url: getMyBusinessesUrl);
      final decoded = response.data;

      debugPrint(decoded.toString());
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        // Cast the businesses list to a List<BusinessModel>
        return ApiBaseResponse.fromJson(
          decoded,
          (json) => ((json as Map<String, dynamic>)['data']['businesses'])
                  .isEmpty
              ? <BusinessModel>[]
              : (json['data']['businesses'] as List<dynamic>)
                  .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse> verifyBusiness(
      {required VerifyBusinessEntity data}) async {
    try {
      final res = await _client.post(url: verifyBusinessUrl, bodyData: data);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(decoded, (json) => json);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse> rateBusiness(
      {required RateBusinessEntity data}) async {
    try {
      final res = await _client.post(url: rateBusinessUrl, bodyData: data);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(decoded, (json) => json);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponse> shareBusiness(
      {required ShareBusinessEntity data}) async {
    try {
      final res = await _client.post(url: shareBusinessUrl, bodyData: data);
      final decoded = res.data;
      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponse.fromJson(decoded, (json) => json);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<ApiBaseResponseNoData> addToFavoriteBusiness(
      {required AddBusinessToFavouriteEntity data}) async {
    try {
      final res = await _client.post(url: favoriteBusinessUrl, bodyData: data);
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

  Future<ApiBaseResponseNoData> deleteMyBusiness(
      {required String businessId}) async {
    try {
      final String url = '$deleteBusinessUrl/$businessId';
      final response = await _client.delete(url: url);
      final decoded = response.data;

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
