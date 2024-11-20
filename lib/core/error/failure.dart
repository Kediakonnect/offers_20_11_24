import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
}

// General Failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  final String? message;

  const CacheFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class InternetFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ApiFailure extends Failure {
  @override
  final String? message;

  const ApiFailure({this.message});
  @override
  List<Object?> get props => [MessageCodec];
}

class FirbaseMyFailure extends Failure {
  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NormalFailure extends Failure {
  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  @override
  List<Object?> get props => [message];
}
