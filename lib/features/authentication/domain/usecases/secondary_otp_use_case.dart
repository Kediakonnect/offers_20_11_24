import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/secondary_otp.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class SecondaryOtpUseCase
    implements UseCase<ApiBaseResponse<SecondaryOtpModel>, SecondaryOtpEntity> {
  final AuthRepository _authRepository;

  const SecondaryOtpUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<SecondaryOtpModel>>> call(
      SecondaryOtpEntity entity) {
    return _authRepository.sendSecondaryOtp(entity: entity);
  }
}
