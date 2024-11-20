import 'package:equatable/equatable.dart';

class PasswordResetEntity extends Equatable {
  final String mobile, password, confirmPassword;

  const PasswordResetEntity(
      {required this.mobile,
      required this.confirmPassword,
      required this.password});

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password_confirmation": confirmPassword,
        "password": password
      };

  @override
  List<Object?> get props => [mobile, confirmPassword, password];
}
