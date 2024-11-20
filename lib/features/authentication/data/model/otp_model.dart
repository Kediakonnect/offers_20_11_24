class OtpModel {
  final int otp;

  const OtpModel({required this.otp});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      otp: json['otp'],
    );
  }
}

class OtpModelForgotPassword {
  final String otp;

  const OtpModelForgotPassword({required this.otp});

  factory OtpModelForgotPassword.fromJson(Map<String, dynamic> json) {
    return OtpModelForgotPassword(
      otp: json['otp'],
    );
  }
}
