class RegisterUserModel {
  final String mobile;
  final String? referalCode;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String sex;
  final String state;
  final String isMetro;
  final String district;
  final String taluka;
  final String pinCode;
  final String? secondaryMobile;
  final String? email;
  final String status;
  final String updatedAt;
  final String createdAt;
  final String id;

  RegisterUserModel({
    required this.mobile,
    this.referalCode,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.sex,
    required this.state,
    required this.isMetro,
    required this.district,
    required this.taluka,
    required this.pinCode,
    this.secondaryMobile,
    this.email,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  // Factory constructor for creating a new RegisterUserModel instance from a map.
  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      mobile: json['mobile'] ?? '',
      referalCode: json['referalCode'] as String?,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      sex: json['sex'] ?? '',
      state: json['state'] ?? '',
      isMetro: json['is_metro'] ?? '',
      district: json['district'] ?? '',
      taluka: json['taluka'] ?? '',
      pinCode: json['pin_code'] ?? '',
      secondaryMobile: json['secondary_mobile'] as String?,
      email: json['email'] as String?,
      status: json['status'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  // Method to convert a RegisterUserModel instance into a map.
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'referalCode': referalCode,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'sex': sex,
      'state': state,
      'is_metro': isMetro,
      'district': district,
      'taluka': taluka,
      'pin_code': pinCode,
      'secondary_mobile': secondaryMobile,
      'email': email,
      'status': status,
      'updated_at': updatedAt,
      'created_at': createdAt,
      '_id': id,
    };
  }
}

class RegisterModel {
  final RegisterUserModel user;
  final String token;

  RegisterModel({
    required this.user,
    required this.token,
  });

  // Factory constructor for creating a new RegisterModel instance from a map.
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      user: RegisterUserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  // Method to convert an AuthResponse instance into a map.
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}
