class RegisterScreenThreeEntity {
  final String firstName;
  final String lastName;
  final String dob;
  final String sex;
  final String state;
  final String? district;
  final String? area;
  final bool isMetroCity;
  // final String? pinCode;
  final String phoneNumber;
  final String? referralCode;

  RegisterScreenThreeEntity({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.sex,
    required this.state,
    this.district,
    this.area,
    required this.isMetroCity,
    // required this.pinCode,
    required this.phoneNumber,
    required this.referralCode,
  });
}
