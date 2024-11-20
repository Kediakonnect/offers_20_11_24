class ViewOfferEntity {
  String offerId;

  ViewOfferEntity({required this.offerId});

  Map<String, dynamic> toJson() {
    return {
      'offer_id': offerId,
    };
  }
}
