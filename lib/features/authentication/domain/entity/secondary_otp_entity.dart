import 'package:equatable/equatable.dart';

class SecondaryOtpEntity extends Equatable {
  final String? secondaryNumber;
  final String? secondaryEmail;

  const SecondaryOtpEntity({
    this.secondaryNumber,
    this.secondaryEmail,
  });

  Map<String, dynamic> toJson() {
    return {"mobile": secondaryNumber, "email": secondaryEmail};
  }

  @override
  List<Object?> get props => [secondaryEmail, secondaryNumber];
}
