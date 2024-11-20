import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';

class BusinessOfferResponseModel {
  final List<BusinessModel> businesses;
  final List<OfferModel> offers;

  BusinessOfferResponseModel({
    required this.businesses,
    required this.offers,
  });

  factory BusinessOfferResponseModel.fromJson(Map<String, dynamic> json) {
    final business = json['data']['businesses'] as List<dynamic>;

    final offer = json['data']['offers'] as List<dynamic>;
    return BusinessOfferResponseModel(
      businesses: (business)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (offer)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
