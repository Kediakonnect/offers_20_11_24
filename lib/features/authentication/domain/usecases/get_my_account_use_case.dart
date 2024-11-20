import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/authentication/data/model/account_model.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';

class GetMyAccountUseCase implements UseCase<User, NoParams> {
  final AuthRepository _authRepository;

  const GetMyAccountUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(NoParams entity) {
    return _authRepository.getMuAccount();
  }
}
