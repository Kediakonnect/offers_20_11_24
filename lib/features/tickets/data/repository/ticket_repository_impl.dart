import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/tickets/data/data_sources/ticket_data_sources.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';
import 'package:divyam_flutter/features/tickets/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketDataSources _ticketDataSources;
  final NetworkInfo _networkInfo;

  TicketRepositoryImpl(
      {required TicketDataSources ticketDataSources,
      required NetworkInfo networkInfo})
      : _ticketDataSources = ticketDataSources,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> createTicket(
      {required CreateTicketEntity entity}) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _ticketDataSources.createTicket(entity: entity);

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
