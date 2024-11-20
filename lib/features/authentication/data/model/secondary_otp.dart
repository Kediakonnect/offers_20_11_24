class SecondaryOtpModel {
  final int? mobileOtp;
  final int? emailOtp;

  SecondaryOtpModel({
    this.emailOtp,
    this.mobileOtp,
  });

  factory SecondaryOtpModel.fromJson(Map<String, dynamic> json) {
    return SecondaryOtpModel(
      emailOtp: json['email_otp'],
      mobileOtp: json['mobile_otp'],
    );
  }

  // Method to convert a ForgotPasswordModel instance into a map.
  Map<String, dynamic> toJson() {
    return {
      "email_otp": emailOtp,
      "mobile_otp": mobileOtp,
    };
  }
}
