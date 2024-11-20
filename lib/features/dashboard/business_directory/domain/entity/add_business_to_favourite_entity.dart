class AddBusinessToFavouriteEntity {
  final String businessId;
  final String status;

  AddBusinessToFavouriteEntity({
    required this.businessId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {"business_id": businessId, "status": status};
  }
}
