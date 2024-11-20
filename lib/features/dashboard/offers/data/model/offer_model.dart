import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/utils/download_image.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/entity/create_offer_entity.dart';
import 'package:flutter/material.dart';

int parseToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value) ?? 0;
  } else {
    return 0; // Default value if null or unexpected type
  }
}

class OfferModel {
  final String? id;
  final String? productName;
  final Business? businessId;
  final String offerType;
  final String offerBuySell;
  final List<OfferTitle> offerTitle;
  final String targetAllAges;
  final String? status;
  final String? fromAge;
  final String? toAge;
  final String targetSex;
  final List<Location>? location;
  final String? startDate;
  final String? endDate;
  final String? image;
  final Product productId;
  final Category categoryLevel1;
  final Category categoryLevel2;
  final Category categoryLevel3;
  final String originalPrice;
  final String? referralMobile;
  final String? offerPrice;
  final String? userId;
  final String updatedAt;
  final String createdAt;
  final String? coins;
  final int? views;
  final int? shareCount;
  final int? likeCount;
  final int? dislikeCount;
  final int? favoriteCount;
  final bool isFavourite;
  final bool isLiked;
  final bool isDisliked;
  final bool isShared;

  OfferModel({
    required this.id,
    required this.businessId,
    required this.offerType,
    required this.offerBuySell,
    required this.offerTitle,
    required this.targetAllAges,
    this.status,
    this.fromAge,
    this.toAge,
    required this.targetSex,
    required this.isLiked,
    required this.isDisliked,
    required this.isShared,
    this.location,
    this.startDate,
    this.endDate,
    this.image,
    required this.productId,
    required this.categoryLevel1,
    required this.categoryLevel2,
    required this.categoryLevel3,
    required this.originalPrice,
    this.referralMobile,
    this.productName,
    this.offerPrice,
    this.userId,
    required this.updatedAt,
    required this.createdAt,
    this.coins,
    this.views,
    this.dislikeCount,
    this.favoriteCount,
    this.likeCount,
    this.shareCount,
    required this.isFavourite,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    try {
      return OfferModel(
        id: json['_id'],
        productName: json['product_name'],
        businessId: Business.fromJson(json['business_id']),
        offerType: json['offer_type'],
        offerBuySell: json['offer_buy_sell'],
        offerTitle: List<OfferTitle>.from(
            json['offer_title'].map((x) => OfferTitle.fromJson(x))),
        targetAllAges: json['target_all_ages'],
        status: json['status'] ?? 'Pending',
        fromAge: json['from_age'],
        toAge: json['to_age'],
        targetSex: json['target_sex'],
        location: json['location'] != null && json['location'] is! int
            ? List<Location>.from(
                json['location'].map((x) => Location.fromJson(x)),
              )
            : [],
        startDate: json['start_date'],
        endDate: json['end_date'],
        image: json['image'],
        productId: Product.fromJson(json['product_id'] ?? {}),
        categoryLevel1: Category.fromJson(json['category_level_1']),
        categoryLevel2: Category.fromJson(json['category_level_2']),
        categoryLevel3: Category.fromJson(json['category_level_3']),
        originalPrice: json['original_price'],
        referralMobile: json['referral_moblie'],
        offerPrice: json['offer_price'],
        userId: json['user_id'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        coins: json['coins'],
        likeCount: parseToInt(json['like']),
        shareCount: parseToInt(json['share']),
        dislikeCount: parseToInt(json['dislike']),
        favoriteCount: parseToInt(json['favourite']),
        isLiked: json['is_like'] == 0 ? false : true,
        isDisliked: json['is_dislike'] == 0 ? false : true,
        isShared: json['is_share'] == 0 ? false : true,
        views: parseToInt(json['views']), // Nullable integer
        isFavourite: json['is_favourite'] == 0 ? false : true,
      );
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'business_id': businessId,
      'offer_type': offerType,
      'offer_buy_sell': offerBuySell,
      'offer_title': List<dynamic>.from(offerTitle.map((x) => x.toJson())),
      'target_all_ages': targetAllAges,
      'status': status,
      'from_age': fromAge,
      'to_age': toAge,
      'target_sex': targetSex,
      // 'location': location.toJson(),
      'start_date': startDate,
      'end_date': endDate,
      'image': image,
      'product_id': productId.toJson(),
      'category_level_1': categoryLevel1.toJson(),
      'category_level_2': categoryLevel2.toJson(),
      'category_level_3': categoryLevel3.toJson(),
      'original_price': originalPrice,
      'product_name': productName,
      'referral_moblie': referralMobile,
      'offer_price': offerPrice,
      'user_id': userId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'coins': coins,
      'views': views, // Nullable integer
    };
  }

  Future<CreateOfferEntity> toEntity() async {
    return CreateOfferEntity(
      businessId: businessId?.id ?? '',
      offerId: id,
      offerType: offerType,
      offerBuySell: offerBuySell,
      offerTitle: offerTitle
          .map((offer) => OfferTitleEntity(
                language: offer.language,
                title: offer.title,
                description: offer.description,
              ))
          .toList(),
      targetAllAges: targetAllAges == '1',

      fromAge: fromAge,
      toAge: toAge,
      targetSex: targetSex,
      location: '', // Add location conversion here if needed
      startDate: startDate,
      endDate: endDate,
      image: image != null
          ? await NetworkImageHelper.downloadAndSaveImageTemp(image!)
          : null,
      productId: productId.id,
      originalPrice: originalPrice,
      offerPrice: offerPrice ?? '',
      categoryLevel1: categoryLevel1.id,
      categoryLevel2: categoryLevel2.id,
      categoryLevel3: categoryLevel3.id,
      categoryLevel4: '',
      coins: coins ?? '0',
      referralMobile: referralMobile,
    );
  }
}

class Business {
  final String id;
  final String name;
  // final String? logoImage;
  final String primaryImage;
  // final List<String>? secondaryImages;
  // final String mobile;
  // final String email;
  // final String contactPerson;
  // final String? state;
  // final String? district;
  // final String? taluka;
  // final Category categoryLevel1;
  // final Category categoryLevel2;

  Business({
    required this.id,
    required this.name,
    // this.logoImage,
    required this.primaryImage,
    // this.secondaryImages,
    // required this.mobile,
    // required this.email,
    // required this.contactPerson,
    // this.state,
    // this.district,
    // this.taluka,
    // required this.categoryLevel1,
    // required this.categoryLevel2,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    try {
      debugPrint(json['id'].toString());
      return Business(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        // logoImage: json['logo_image'],
        primaryImage: json['primary_image'] ?? '',
        // secondaryImages: json['secondary_images'] != null
        //     ? List<String>.from(json['secondary_images'])
        //     : null,
        // mobile: json['mobile'],
        // email: json['email'],
        // contactPerson: json['contact_person'],
        // state: json['state'],
        // district: json['district'],
        // taluka: json['taluka'],
        // categoryLevel1: Category.fromJson(json['category_level_1']),
        // categoryLevel2: Category.fromJson(json['category_level_2']),
      );
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'logo_image': logoImage,
      'primary_image': primaryImage,
      // 'secondary_images': secondaryImages,
      // 'mobile': mobile,
      // 'email': email,
      // 'contact_person': contactPerson,
      // 'state': state,
      // 'district': district,
      // 'taluka': taluka,
      // 'category_level_1': categoryLevel1.toJson(),
      // 'category_level_2': categoryLevel2.toJson(),
    };
  }
}

class OfferTitle {
  final String language;
  final String title;
  final String description;

  OfferTitle({
    required this.language,
    required this.title,
    required this.description,
  });

  factory OfferTitle.fromJson(Map<String, dynamic> json) {
    return OfferTitle(
      language: json['language'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'title': title,
      'description': description,
    };
  }

  OfferTitleEntity toEntity() {
    return OfferTitleEntity(
      language: language,
      title: title,
      description: description,
    );
  }
}

class Location {
  final StateInfo state;
  final List<District> districts;

  Location({
    required this.state,
    required this.districts,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      state: StateInfo.fromJson(json['state']),
      districts: List<District>.from(
          json['districts'].map((x) => District.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state.toJson(),
      'districts': List<dynamic>.from(districts.map((x) => x.toJson())),
    };
  }
}

class StateInfo {
  final String id;
  final int code;
  final String name;

  StateInfo({
    required this.id,
    required this.code,
    required this.name,
  });

  factory StateInfo.fromJson(Map<String, dynamic> json) {
    return StateInfo(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}

class DistrictInfo {
  final String id;
  final int code;
  final String name;

  DistrictInfo({
    required this.id,
    required this.code,
    required this.name,
  });

  factory DistrictInfo.fromJson(Map<String, dynamic> json) {
    return DistrictInfo(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}

class District {
  final DistrictInfo id;
  final List<Taluaka> taluakas;

  District({
    required this.id,
    required this.taluakas,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: DistrictInfo.fromJson(json['id']),
      taluakas:
          List<Taluaka>.from(json['taluakas'].map((x) => Taluaka.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'taluakas': List<dynamic>.from(taluakas.map((x) => x.toJson())),
    };
  }
}

class Taluaka {
  final String id;
  final int code;
  final String name;

  Taluaka({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Taluaka.fromJson(Map<String, dynamic> json) {
    return Taluaka(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}

class Product {
  final String id;
  final String name;
  final int productCode;

  Product({
    required this.id,
    required this.name,
    required this.productCode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      productCode: json['product_code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'product_code': productCode,
    };
  }
}

class Category {
  final String id;
  final String name;
  final int code;

  Category({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      code: json['code'] ?? json['category_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}
