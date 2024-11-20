import 'package:equatable/equatable.dart';

class VerifyBusinessEntity extends Equatable {
  final String businessId;

  const VerifyBusinessEntity({
    required this.businessId,
  });

  Map<String, dynamic> toJson() {
    return {"business_id": businessId};
  }

  @override
  List<Object?> get props => [businessId];
}
