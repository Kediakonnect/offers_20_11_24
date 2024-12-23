import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params entity);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
