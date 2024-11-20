import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable {
  final String mobile;
  final String? referralCode;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String sex;
  final String state;
  final bool isMetro;
  final String? district;
  final String? taluka;
  // final String pinCode;
  final String password;
  final String passwordConfirmation;
  final String? secondaryMobile;
  final String? email;

  const RegisterUserEntity({
    required this.mobile,
    this.referralCode,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.sex,
    required this.state,
    required this.isMetro,
    this.district,
    this.taluka,
    // required this.pinCode,
    required this.password,
    required this.passwordConfirmation,
    this.secondaryMobile,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "referralCode": referralCode,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "sex": sex,
        "state": state,
        "is_metro": isMetro ? "1" : "0",
        "district": district,
        "taluka": taluka,
        // "pin_code": pinCode,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "secondary_mobile": secondaryMobile,
        "email": email,
      };

  @override
  List<Object?> get props => [
        mobile,
        referralCode,
        firstName,
        lastName,
        dateOfBirth,
        sex,
        state,
        isMetro,
        district,
        taluka,
        // pinCode,
        password,
        passwordConfirmation,
        secondaryMobile,
        email,
      ];
}
