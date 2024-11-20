import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/user_model.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class SignInUseCase
    implements UseCase<ApiBaseResponse<UserModel>, SignInEntity> {
  final AuthRepository _authRepository;

  const SignInUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, ApiBaseResponse<UserModel>>> call(
      SignInEntity entity) {
    return _authRepository.login(entity: entity);
  }
}
