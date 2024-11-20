import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String mobile, password;

  const SignInEntity({
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {"mobile": mobile, "password": password};

  @override
  List<Object> get props => [mobile, password];
}
