import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  final String mobileNumber;

  const ForgotPasswordEntity({required this.mobileNumber});

  Map<String, dynamic> toJson() {
    return {"mobile": mobileNumber};
  }

  @override
  List<Object?> get props => [mobileNumber];
}
