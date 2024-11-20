import 'package:equatable/equatable.dart';

class GenerateOtpEntity extends Equatable {
  final String mobile, refCode;

  const GenerateOtpEntity({required this.mobile, required this.refCode});

  Map<String, dynamic> toJson() => {"mobile": mobile, "referalCode": refCode};

  @override
  List<Object?> get props => [mobile, refCode];
}
