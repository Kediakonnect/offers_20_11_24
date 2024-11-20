class PasswordResetOptionEntity {
  final String mobile;
  final String? secondaryMobile;
  final String? email;

  PasswordResetOptionEntity({
    required this.mobile,
    required this.secondaryMobile,
    required this.email,
  });
}
