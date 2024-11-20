import 'package:divyam_flutter/features/authentication/presentation/pages/otp_screen.dart';

class OtpScreenEntity {
  final String mobileNumber;
  final OTPMode otpMode;
  final int otp;
  final String? referralCode;

  OtpScreenEntity({
    required this.mobileNumber,
    required this.otpMode,
    required this.otp,
    this.referralCode,
  });
}
