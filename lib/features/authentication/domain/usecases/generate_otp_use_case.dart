import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/otp_model.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/generate_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class GenerateOtpUse
    implements UseCase<ApiBaseResponse<OtpModel>, GenerateOtpEntity> {
  final AuthRepository _authRepository;

  const GenerateOtpUse({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, ApiBaseResponse<OtpModel>>> call(
      GenerateOtpEntity entity) {
    return _authRepository.generateOTP(entity: entity);
  }
}
