import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';

abstract class TicketRepository {
  Future<Either<Failure, ApiBaseResponseNoData>> createTicket(
      {required CreateTicketEntity entity});
}
