import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';

class BusinessOfferListEntity {
  final List<BusinessModel> businesses;
  final List<OfferModel> offers;

  BusinessOfferListEntity({
    required this.businesses,
    required this.offers,
  });

  BusinessOfferListEntity copyWith({
    List<BusinessModel>? businesses,
    List<OfferModel>? offers,
  }) {
    return BusinessOfferListEntity(
      businesses: businesses ?? this.businesses,
      offers: offers ?? this.offers,
    );
  }
}
