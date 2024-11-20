class GetAllOffersEntity {
  final String offerType;
  final String? categoryLevel1;
  final String? categoryLevel2;
  final String? categoryLevel3;
  final String? productId;
  final String? stateId;
  final String? districtId;
  final String? talukaId;

  GetAllOffersEntity({
    required this.offerType,
    this.categoryLevel1,
    this.categoryLevel2,
    this.categoryLevel3,
    this.productId,
    this.stateId,
    this.districtId,
    this.talukaId,
  });

  /// Converts the entity to a query parameters map
  Map<String, String> toQueryParameters() {
    // Determine which category/product parameter to include
    MapEntry<String, String>? categoryEntry;

    if (productId != null) {
      categoryEntry = MapEntry('product_id', productId!);
    } else if (categoryLevel3 != null) {
      categoryEntry = MapEntry('category_level_3', categoryLevel3!);
    } else if (categoryLevel2 != null) {
      categoryEntry = MapEntry('category_level_2', categoryLevel2!);
    } else if (categoryLevel1 != null) {
      categoryEntry = MapEntry('category_level_1', categoryLevel1!);
    }

    return {
      'offer_type': offerType,
      if (categoryEntry != null) categoryEntry.key: categoryEntry.value,
      if (stateId != null) 'state_id': stateId!,
      if (districtId != null) 'district_id': districtId!,
      if (talukaId != null) 'taluka_id': talukaId!,
    };
  }

  /// Creates a copy of the entity with modified fields
  GetAllOffersEntity copyWith({
    String? offerType,
    String? categoryLevel1,
    String? categoryLevel2,
    String? categoryLevel3,
    String? productId,
    String? stateId,
    String? districtId,
    String? talukaId,
  }) {
    return GetAllOffersEntity(
      offerType: offerType ?? this.offerType,
      categoryLevel1: categoryLevel1 ?? this.categoryLevel1,
      categoryLevel2: categoryLevel2 ?? this.categoryLevel2,
      categoryLevel3: categoryLevel3 ?? this.categoryLevel3,
      productId: productId ?? this.productId,
      stateId: stateId ?? this.stateId,
      districtId: districtId ?? this.districtId,
      talukaId: talukaId ?? this.talukaId,
    );
  }

  GetAllOffersEntity clearCategoriesFilters() {
    return GetAllOffersEntity(
      offerType: 'screen',
      categoryLevel1: null,
      categoryLevel2: null,
      categoryLevel3: null,
      productId: null,
      stateId: stateId,
      districtId: districtId,
      talukaId: talukaId,
    );
  }

  GetAllOffersEntity clearStateFilters() {
    return GetAllOffersEntity(
      offerType: 'screen',
      categoryLevel1: categoryLevel1,
      categoryLevel2: categoryLevel2,
      categoryLevel3: categoryLevel3,
      productId: productId,
      stateId: null,
      districtId: null,
      talukaId: null,
    );
  }

  /// Factory method to create an empty instance
  factory GetAllOffersEntity.toEmpty() {
    return GetAllOffersEntity(
      offerType: 'screen',
      categoryLevel1: null,
      categoryLevel2: null,
      categoryLevel3: null,
      productId: null,
      stateId: null,
      districtId: null,
      talukaId: null,
    );
  }
}
