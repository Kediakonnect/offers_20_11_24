import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Offer {
  final String id;
  final String offerType;
  final String targetSex;
  final String offerBuySell;
  final DateTime? startDate;
  final DateTime? endDate;
  final String image;
  final List<OfferTitle> offerTitle;
  final Product productId;
  final Category categoryLevel1;
  final Category categoryLevel2;
  final Category categoryLevel3;

  Offer({
    required this.id,
    required this.offerType,
    required this.targetSex,
    required this.offerBuySell,
    this.startDate,
    this.endDate,
    required this.image,
    required this.offerTitle,
    required this.productId,
    required this.categoryLevel1,
    required this.categoryLevel2,
    required this.categoryLevel3,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      offerType: json['offer_type'],
      targetSex: json['target_sex'],
      offerBuySell: json['offer_buy_sell'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      image: json['image'],
      offerTitle: (json['offer_title'] as List)
          .map((e) => OfferTitle.fromJson(e))
          .toList(),
      productId: Product.fromJson(json['product_id']),
      categoryLevel1: Category.fromJson(json['category_level_1']),
      categoryLevel2: Category.fromJson(json['category_level_2']),
      categoryLevel3: Category.fromJson(json['category_level_3']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offer_type': offerType,
      'target_sex': targetSex,
      'offer_buy_sell': offerBuySell,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'image': image,
      'offer_title': offerTitle.map((e) => e.toJson()).toList(),
      'product_id': productId.toJson(),
      'category_level_1': categoryLevel1.toJson(),
      'category_level_2': categoryLevel2.toJson(),
      'category_level_3': categoryLevel3.toJson(),
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
}

class Product {
  final String id;
  final int productCode;
  final String name;

  Product({
    required this.id,
    required this.productCode,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productCode: json['product_code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_code': productCode,
      'name': name,
    };
  }
}

class Location {
  final String id;
  final String name;
  final int areaCode;

  Location({
    required this.id,
    required this.name,
    required this.areaCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      areaCode: json['area_code'] ?? 0,
    );
  }
}

class BusinessModel {
  final String id;
  final String userId;
  final String name;
  final String? logoImage;
  final String mobile;
  final String email;
  final String contactPerson;
  final String? websiteUrl;
  final String? whatsappNumber;
  final Location? state;
  final String metroCity;
  final Location? district;
  final Location? taluka;
  final String registeredAddress;
  final String pinCode;
  final String googleMapLink;
  final String openingTime;
  final String closingTime;
  final Category categoryLevel1;
  final Category categoryLevel2;
  final List<CategoryModel> categoryLevel3;
  final String? primaryImage;
  final bool? isVerified;
  final double? rating;
  final int? shareCount;
  final List<String>? secondaryImages;
  final bool isFavourite;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<Offer>? offers;

  BusinessModel({
    required this.id,
    required this.userId,
    required this.name,
    this.logoImage,
    required this.mobile,
    required this.email,
    required this.contactPerson,
    this.websiteUrl,
    this.whatsappNumber,
    this.state,
    required this.metroCity,
    this.district,
    this.taluka,
    required this.registeredAddress,
    required this.pinCode,
    required this.googleMapLink,
    required this.openingTime,
    required this.closingTime,
    required this.categoryLevel1,
    required this.categoryLevel2,
    required this.categoryLevel3,
    this.primaryImage,
    this.secondaryImages,
    required this.updatedAt,
    required this.createdAt,
    this.isVerified,
    this.rating,
    this.shareCount,
    required this.isFavourite,
    this.offers,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['_id'] as String,
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      logoImage: json['logo_image'] as String?,
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      contactPerson: json['contact_person'] ?? '',
      websiteUrl: json['website_url'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      state:
          json['state_id'] != null ? Location.fromJson(json['state_id']) : null,
      metroCity: json['metro_city'] ?? '',
      district: json['district_id'] != null
          ? Location.fromJson(json['district_id'])
          : null,
      taluka: json['taluka_id'] != null
          ? Location.fromJson(json['taluka_id'])
          : null,
      registeredAddress: json['registered_address'] ?? '',
      pinCode: json['pin_code'] ?? '',
      googleMapLink: json['google_map_link'] ?? '',
      openingTime: json['opening_time'] ?? '',
      closingTime: json['closing_time'] ?? '',
      categoryLevel1: json['category_level_1'] != null
          ? Category.fromJson(json['category_level_1'] as Map<String, dynamic>)
          : Category(id: '', name: ''),
      categoryLevel2: json['category_level_2'] != null
          ? Category.fromJson(json['category_level_2'] as Map<String, dynamic>)
          : Category(id: '', name: ''),
      categoryLevel3: (json['category_level_3'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      primaryImage: json['primary_image'] as String?,
      secondaryImages: json['secondary_images'] != null
          ? (json['secondary_images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
          : null,
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      isVerified: json['is_verifiy'] == "0" ? false : true,
      rating: json['rating']?.toDouble(),
      shareCount: json['Businesshare_count'] ?? 0,
      isFavourite: json['is_favourite'] == 0 ? false : true,
      offers: (json['offer_id'] as List<dynamic>?)
              ?.map((e) => Offer.fromJson(e))
              .toList() ??
          [],
    );
  }

  BusinessEntity toEntity() {
    return BusinessEntity(
      name: name,
      mobile: mobile,
      isNeworkImages: true,
      email: email,
      contactPerson: contactPerson,
      categoryLevel1Value: categoryLevel1.name,
      categoryLevel2Value: categoryLevel2.name,
      categoryLevel3Value: categoryLevel3.map((e) => e.name).toList(),
      websiteUrl: websiteUrl ?? '',
      whatsappNumber: whatsappNumber,
      state: state?.id ?? '',
      metroCity: metroCity,
      district: district?.id ?? '',
      taluka: taluka?.id ?? '',
      stateValue: state?.name,
      talukaValue: taluka?.name,
      districtValue: district?.name,
      registeredAddress: registeredAddress,
      pinCode: pinCode,
      googleMapLink: googleMapLink,
      openingTime: openingTime,
      closingTime: closingTime,
      categoryName: categoryLevel1.id,
      categoryLevel1: categoryLevel1.id,
      categoryLevel2: categoryLevel2.id,
      secondaryImages: secondaryImages ?? [],
      primaryImage: primaryImage ?? '',
      logoImage: logoImage ?? '',
      stateName: state?.name ?? '',
      districtName: district?.name ?? '',
      talukaName: taluka?.name ?? '',
      businessId: id,
      categoryLevel3: categoryLevel3.map((e) => e.id).toList() ?? [],
      isVerified: isVerified ?? false,
      rating: rating,
      shareCount: shareCount,
      isFavourite: isFavourite,
      offers: offers,
    );
  }
}
