import 'package:equatable/equatable.dart';

class ForgotPasswordOtpEntity extends Equatable {
  final String mobileNumber;

  const ForgotPasswordOtpEntity({required this.mobileNumber});

  Map<String, dynamic> toJson() {
    return {"email_or_phone": mobileNumber};
  }

  @override
  List<Object?> get props => [mobileNumber];
}
