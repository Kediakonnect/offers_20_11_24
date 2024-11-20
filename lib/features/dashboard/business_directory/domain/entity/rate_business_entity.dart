import 'package:equatable/equatable.dart';

class RateBusinessEntity extends Equatable {
  final String businessId;
  final String rating;

  const RateBusinessEntity({
    required this.businessId,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {"business_id": businessId, "rating": rating};
  }

  @override
  List<Object?> get props => [businessId, rating];
}
