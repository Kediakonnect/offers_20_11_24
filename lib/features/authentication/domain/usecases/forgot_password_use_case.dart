import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/forgot_password.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase
    implements
        UseCase<ApiBaseResponse<ForgotPasswordModel>, ForgotPasswordEntity> {
  final AuthRepository _authRepository;

  const ForgotPasswordUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<ForgotPasswordModel>>> call(
      ForgotPasswordEntity entity) {
    return _authRepository.forgotPassword(entity: entity);
  }
}
