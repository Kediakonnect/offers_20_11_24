import 'package:divyam_flutter/features/dashboard/business_directory/data/model/business_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_offer_list_entity.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';

class BusinessOfferListHelper {
  static BusinessOfferListEntity createOfferEntityList(
      List<BusinessModel> businesses, List<OfferModel> offers) {
    return BusinessOfferListEntity(
      businesses: businesses,
      offers: offers,
    );
  }
}
