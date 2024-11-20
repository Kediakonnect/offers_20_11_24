class GetMyOffersEntity {
  final String search;

  GetMyOffersEntity({required this.search});

  Map<String, dynamic> toJson() {
    return {
      'search': search,
    };
  }
}
