import 'package:dartz/dartz.dart';
import 'package:divyam_flutter/core/error/failure.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/core/usecase/use_case.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';
import 'package:divyam_flutter/features/tickets/domain/repository/ticket_repository.dart';

class CreateTicketUseCase
    implements UseCase<ApiBaseResponseNoData, CreateTicketEntity> {
  final TicketRepository _ticketRepository;

  const CreateTicketUseCase({required TicketRepository ticketRepository})
      : _ticketRepository = ticketRepository;

  @override
  Future<Either<Failure, ApiBaseResponseNoData>> call(
      CreateTicketEntity entity) {
    return _ticketRepository.createTicket(entity: entity);
  }
}
