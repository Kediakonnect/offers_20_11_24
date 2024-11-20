import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/register_model.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_user_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class RegisterUserUseCase
    implements UseCase<ApiBaseResponse<RegisterModel>, RegisterUserEntity> {
  final AuthRepository _authRepository;

  const RegisterUserUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, ApiBaseResponse<RegisterModel>>> call(
      RegisterUserEntity entity) {
    return _authRepository.register(entity: entity);
  }
}
