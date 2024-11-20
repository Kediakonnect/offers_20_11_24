import 'dart:ffi';

class ApiBaseResponse<T> {
  final String message;
  final T? data;
  final bool success;

  ApiBaseResponse({
    required this.message,
    required this.data,
    required this.success,
  });

  factory ApiBaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiBaseResponse(
      message: json['message'] ?? 'Something went wrong',
      data: T is Void ? null : fromJsonT(json),
      success: json['success'] as bool,
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'message': message,
      'data': data == null ? {} : toJsonT(data as T),
      'success': success,
    };
  }
}

class ApiBaseResponseNoData {
  final String message;
  final bool success;

  ApiBaseResponseNoData({
    required this.message,
    required this.success,
  });

  factory ApiBaseResponseNoData.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiBaseResponseNoData(
      message: json['message'] ?? 'Something went wrong',
      success: json['success'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
    };
  }
}
