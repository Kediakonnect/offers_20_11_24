import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/authentication/data/model/account_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/forgot_password.dart';
import 'package:divyam_flutter/features/authentication/data/model/otp_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/register_model.dart';
import 'package:divyam_flutter/features/authentication/data/model/secondary_otp.dart';
import 'package:divyam_flutter/features/authentication/data/model/user_model.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/generate_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_user_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/sign_in_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiBaseResponse<OtpModel>>> generateOTP(
      {required GenerateOtpEntity entity});

  Future<Either<Failure, ApiBaseResponse<UserModel>>> login(
      {required SignInEntity entity});

  Future<Either<Failure, ApiBaseResponse<RegisterModel>>> register(
      {required RegisterUserEntity entity});

  Future<Either<Failure, ApiBaseResponse<ForgotPasswordModel>>> forgotPassword(
      {required ForgotPasswordEntity entity});

  Future<Either<Failure, ApiBaseResponse<OtpModel>>> forgotPasswordSendOtp(
      {required ForgotPasswordOtpEntity entity});

  Future<Either<Failure, ApiBaseResponseNoData>> resetPassword(
      {required PasswordResetEntity entity});

  Future<Either<Failure, ApiBaseResponse<SecondaryOtpModel>>> sendSecondaryOtp(
      {required SecondaryOtpEntity entity});

  Future<Either<Failure, User>> getMuAccount();
}
