import 'package:divyam_flutter/core/constants/url_constants.dart';

class CategoryEntity {
  final String? level1Id;
  final String? level2Id;
  final String? level3Id;
  final String? level4Id;
  final int? categorylevel;

  CategoryEntity({
    this.level1Id,
    this.level2Id,
    this.level3Id,
    this.level4Id,
    this.categorylevel = 1,
  });

  CategoryEntity copyWith({
    String? level1Id,
    String? level2Id,
    String? level3Id,
    String? level4Id,
    int? categorylevel,
  }) {
    return CategoryEntity(
      level1Id: level1Id,
      level2Id: level2Id,
      level3Id: level3Id,
      level4Id: level4Id,
      categorylevel: categorylevel ?? this.categorylevel,
    );
  }

  String get url {
    final queryParameters = <String, String?>{
      'level1_category_id': level1Id,
      'level2_category_id': level2Id,
      'level3_category_id': level3Id,
      'level4_category_id': level4Id,
    };

    final filteredParameters = queryParameters.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    return '$getBusinessCategoryUrl?$filteredParameters';
  }
}
