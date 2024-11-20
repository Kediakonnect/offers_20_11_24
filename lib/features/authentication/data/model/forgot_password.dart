class ForgotPasswordModel {
  final String user;
  final String mobile;
  final String? secondaryMobile;
  final String? email;

  ForgotPasswordModel({
    required this.user,
    required this.mobile,
    this.secondaryMobile,
    this.email,
  });

  // Factory constructor for creating a new ForgotPasswordModel instance from a map.
  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      user: json['user'],
      mobile: json['mobile'],
      secondaryMobile: json['secondary_mobile'],
      email: json['email'],
    );
  }

  // Method to convert a ForgotPasswordModel instance into a map.
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'mobile': mobile,
      'secondary_mobile': secondaryMobile,
      'email': email,
    };
  }
}
