import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class ResetPasswordUseCase
    implements UseCase<ApiBaseResponseNoData, PasswordResetEntity> {
  final AuthRepository _authRepository;

  const ResetPasswordUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      PasswordResetEntity entity) {
    return _authRepository.resetPassword(entity: entity);
  }
}
