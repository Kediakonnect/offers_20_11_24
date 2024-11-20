import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/authentication/data/data_sources/auth_remote_data_sources.dart';
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
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSources _authRemoteDataSources;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
      {required AuthRemoteDataSources repo, required NetworkInfo networkInfo})
      : _authRemoteDataSources = repo,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ApiBaseResponse<OtpModel>>> generateOTP(
      {required GenerateOtpEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.generateOTP(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<UserModel>>> login(
      {required SignInEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.login(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<RegisterModel>>> register(
      {required RegisterUserEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.register(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<ForgotPasswordModel>>> forgotPassword(
      {required ForgotPasswordEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.forgotPassword(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<OtpModel>>> forgotPasswordSendOtp(
      {required ForgotPasswordOtpEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res =
            await _authRemoteDataSources.forgotPasswordSendOtp(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return const Left(ApiFailure(message: 'Failed to generate OTP'));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> resetPassword(
      {required PasswordResetEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.resetPassword(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, ApiBaseResponse<SecondaryOtpModel>>> sendSecondaryOtp(
      {required SecondaryOtpEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res =
            await _authRemoteDataSources.sendSecondaryOtp(entity: entity);
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getMuAccount() async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _authRemoteDataSources.getMyAccount();
        return Right(res);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else if (e is ApiException) {
          return Left(ApiFailure(message: e.message));
        } else {
          return Left(NormalFailure());
        }
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
