import 'package:divyam_flutter/core/constants/url_constants.dart';

class GetAllBusinessEntity {
  final String? level1Id;
  final String? level2Id;
  final String? level3Id;
  final String? level4Id;
  final String? city;

  GetAllBusinessEntity({
    this.level1Id,
    this.level2Id,
    this.level3Id,
    this.level4Id,
    this.city,
  });

  GetAllBusinessEntity copyWith({
    String? level1Id,
    String? level2Id,
    String? level3Id,
    String? level4Id,
    String? city,
  }) {
    return GetAllBusinessEntity(
      level1Id: level1Id ?? this.level1Id,
      level2Id: level2Id ?? this.level2Id,
      level3Id: level3Id ?? this.level3Id,
      level4Id: level4Id ?? this.level4Id,
      city: city,
    );
  }

  String get url {
    final queryParameters = <String, String?>{
      'category_level_1': level1Id,
      'category_level_2': level2Id,
      'category_level_3': level3Id,
      'category_level_4': level4Id,
      'talukas_id': city,
    };

    final filteredParameters = queryParameters.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    return '$getAllBusinessesAndOffersUrl?$filteredParameters';
  }
}
