class OfferSocialEntity {
  final String offerId;
  final String status;
  final String url;

  OfferSocialEntity({
    required this.offerId,
    required this.status,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {"offer_id": offerId, "status": status};
  }
}
