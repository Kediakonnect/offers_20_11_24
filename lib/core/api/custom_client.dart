import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/helpers/user_helpers.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';

class CustomHttpClient {
  final Dio _dio;
  late String _accessToken;

  CustomHttpClient({BaseOptions? options})
      : _dio = Dio(options ?? BaseOptions()) {
    // Initialize Dio interceptors for logging and request handling
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the latest token from UserHelpers and update the request headers
        _accessToken = UserHelpers.getAuthToken();
        options.headers['Authorization'] = 'Bearer $_accessToken';

        print('Authorization Header: ${options.headers['Authorization']}');
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        return handler.next(response); // Continue with the response
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          print('401 Unauthorized Error: ${error.response?.data}');

          // Log out the user or handle 401 Unauthorized
          await _logoutUser();

          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: 'Unauthorized - Logging out user',
              // ignore: deprecated_member_use
              type: DioErrorType.badResponse,
              response: error.response,
            ),
          );
        }

        return handler.next(error); // Continue with the error if not handled
      },
    ));

    // Initialize access token from UserHelpers
    _accessToken = UserHelpers.getAuthToken();
  }

  // Method to log out the user
  Future<void> _logoutUser() async {
    // Clear user session, token, and redirect user to login page
    await UserHelpers.deleteAuthToken();

    kNavigatorKey.currentState?.pushReplacementNamed(AppRouter.loginScreen);

    print('User has been logged out due to 401 Unauthorized.');
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
            headers: headers ?? {'Authorization': 'Bearer $_accessToken'}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        }
      }
      throw ApiException(message: e.toString());
    }
  }

  Future<Response> post({
    required String url,
    Map<String, String>? headers,
    required dynamic bodyData,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(bodyData),
        options: Options(
            headers: headers ?? {'Authorization': 'Bearer $_accessToken'}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        }
      }
      throw ApiException(message: e.toString());
    }
  }

  Future<Response> put({
    required String url,
    Map<String, String>? headers,
    required dynamic bodyData,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: jsonEncode(bodyData),
        options: Options(
            headers: headers ?? {'Authorization': 'Bearer $_accessToken'}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        }
      }
      throw ApiException(message: e.toString());
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, String>? headers,
    dynamic bodyData,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: jsonEncode(bodyData),
        options: Options(
            headers: headers ?? {'Authorization': 'Bearer $_accessToken'}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        }
      }
      throw ApiException(message: e.toString());
    }
  }

  Future<Response> createMultipartRequest({
    required FormData formData,
    required String url,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $_accessToken'}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          final errorMessage =
              e.response!.data['message'] ?? 'An error occurred';
          throw ApiException(message: errorMessage);
        }
      }
      throw ApiException(message: e.toString());
    }
  }
}
