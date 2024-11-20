import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:equatable/equatable.dart';

class CreateOfferEntity {
  final String businessId;
  final String? offerId;
  final String offerType;
  final CreateOfferType? offerFormType;
  final String offerBuySell;
  final List<OfferTitleEntity> offerTitle;
  final bool targetAllAges;
  final String? fromAge;
  final String? toAge;
  final String targetSex;
  final String location; // Converted to a string, assuming it's JSON formatted
  final String? startDate;
  final String? endDate;
  final File? image;
  final String productId;
  final String originalPrice;
  final String offerPrice;
  final String categoryLevel1;
  final String categoryLevel2;
  final String categoryLevel3;
  final String categoryLevel4;
  final String coins;
  final String? referralMobile;

  CreateOfferEntity({
    required this.businessId,
    required this.offerType,
    this.offerId,
    required this.offerBuySell,
    this.offerFormType,
    required this.offerTitle,
    required this.targetAllAges,
    this.fromAge,
    this.toAge,
    required this.targetSex,
    required this.location,
    this.startDate,
    this.endDate,
    this.image,
    required this.productId,
    required this.originalPrice,
    required this.offerPrice,
    required this.categoryLevel1,
    required this.categoryLevel2,
    required this.categoryLevel3,
    required this.categoryLevel4,
    required this.coins,
    this.referralMobile,
  });

  Future<FormData> toFormData() async {
    MultipartFile? imageMultipart;
    if (image != null) {
      imageMultipart = await MultipartFile.fromFile(image!.path,
          filename: _getFileName(image!.path));
    }

    String offerTitleJson = jsonEncode(offerTitle);

    // Create FormData object
    final dataMap = {
      'business_id': businessId,
      'offer_type': offerType,
      'offer_buy_sell': offerBuySell,
      'offer_title': offerTitleJson,
      'target_all_ages': targetAllAges ? "1" : "0",
      'from_age': fromAge?.toString(),
      'to_age': toAge?.toString(),
      'target_sex': targetSex,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'image': imageMultipart,
      'product_id': categoryLevel4,
      'product_name': productId,
      'original_price': originalPrice.toString(),
      'offer_price': offerPrice.toString(),
      'category_level_1': categoryLevel1,
      'category_level_2': categoryLevel2,
      'category_level_3': categoryLevel3,
      'coins': coins.toString(),
      'referral_moblie': referralMobile,
    };

    // if (offerFormType == CreateOfferType.updateOffer) {
    //   dataMap['_method'] = 'patch';
    // }

    final data = FormData.fromMap(dataMap);

    return data;
  }

  // Factory method for an empty object
  factory CreateOfferEntity.empty() {
    return CreateOfferEntity(
      businessId: '',
      offerType: '',
      offerBuySell: '',
      offerTitle: [],
      targetAllAges: false,
      fromAge: null,
      toAge: null,
      targetSex: '',
      location: '',
      startDate: null,
      endDate: null,
      image: null,
      productId: '',
      originalPrice: '',
      offerPrice: '',
      categoryLevel1: '',
      categoryLevel2: '',
      categoryLevel3: '',
      categoryLevel4: '',
      coins: '0',
      referralMobile: null,
    );
  }

  // CopyWith method
  CreateOfferEntity copyWith({
    String? businessId,
    String? offerId,
    String? offerType,
    String? offerBuySell,
    List<OfferTitleEntity>? offerTitle,
    bool? targetAllAges,
    String? fromAge,
    CreateOfferType? offerFormType,
    String? toAge,
    String? targetSex,
    String? location,
    String? startDate,
    String? endDate,
    File? image,
    String? productId,
    String? originalPrice,
    String? offerPrice,
    String? categoryLevel1,
    String? categoryLevel2,
    String? categoryLevel3,
    String? categoryLevel4,
    String? coins,
    String? referralMobile,
  }) {
    return CreateOfferEntity(
      businessId: businessId ?? this.businessId,
      offerId: offerId ?? this.offerId,
      offerFormType: offerFormType ?? this.offerFormType,
      offerType: offerType ?? this.offerType,
      offerBuySell: offerBuySell ?? this.offerBuySell,
      offerTitle: offerTitle ?? this.offerTitle,
      targetAllAges: targetAllAges ?? this.targetAllAges,
      fromAge: fromAge ?? this.fromAge,
      toAge: toAge ?? this.toAge,
      targetSex: targetSex ?? this.targetSex,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      image: image ?? this.image,
      productId: productId ?? this.productId,
      originalPrice: originalPrice ?? this.originalPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      categoryLevel1: categoryLevel1 ?? this.categoryLevel1,
      categoryLevel2: categoryLevel2 ?? this.categoryLevel2,
      categoryLevel3: categoryLevel3 ?? this.categoryLevel3,
      categoryLevel4: categoryLevel4 ?? this.categoryLevel4,
      coins: coins ?? this.coins,
      referralMobile: referralMobile ?? this.referralMobile,
    );
  }

  // Helper function to get the file name from the file path
  String _getFileName(String filePath) {
    return filePath.split('/').last;
  }
}

class OfferTitleEntity extends Equatable {
  final String language;
  final String title;
  final String description;

  const OfferTitleEntity({
    required this.language,
    required this.title,
    required this.description,
  });

  // The copyWith method
  OfferTitleEntity copyWith({
    String? language,
    String? title,
    String? description,
  }) {
    return OfferTitleEntity(
      language: language ?? this.language,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  factory OfferTitleEntity.toEmpty() {
    return const OfferTitleEntity(
      language: '',
      title: '',
      description: '',
    );
  }

  Map<String, String> toJson() {
    return {
      'language': language,
      'title': title,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        language,
        title,
        description,
      ];
}
