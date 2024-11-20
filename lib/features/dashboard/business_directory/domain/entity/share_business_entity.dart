import 'package:equatable/equatable.dart';

class ShareBusinessEntity extends Equatable {
  final String businessId;
  final String status;

  const ShareBusinessEntity({
    required this.businessId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {"business_id": businessId, "status": status};
  }

  @override
  List<Object?> get props => [businessId, status];
}
