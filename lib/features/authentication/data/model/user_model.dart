class UserModel {
  final String token_type;
  final String access_token;
  UserModel({
    required this.token_type,
    required this.access_token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token_type: json['token_type'],
      access_token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': token_type,
      'access_token': access_token,
    };
  }
}
