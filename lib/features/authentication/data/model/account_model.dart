class User {
  String id;
  String mobile;
  String firstName;
  String lastName;
  String dateOfBirth;
  String sex;
  String state;
  bool isMetro;
  String district;
  String taluka;
  String? secondaryMobile;
  String? email;
  String status;
  DateTime updatedAt;
  DateTime createdAt;

  User({
    required this.id,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.sex,
    required this.state,
    required this.isMetro,
    required this.district,
    required this.taluka,
    this.secondaryMobile,
    this.email,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      mobile: json['mobile'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      sex: json['sex'],
      state: json['state'],
      isMetro: json['is_metro'] == '1',
      district: json['district'],
      taluka: json['taluka'],
      secondaryMobile: json['secondary_mobile'],
      email: json['email'],
      status: json['status'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'sex': sex,
      'state': state,
      'is_metro': isMetro ? '1' : '0',
      'district': district,
      'taluka': taluka,
      'secondary_mobile': secondaryMobile,
      'email': email,
      'status': status,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
