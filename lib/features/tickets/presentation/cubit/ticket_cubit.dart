import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';
import 'package:divyam_flutter/features/tickets/domain/usecases/create_ticket_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final CreateTicketUseCase _createTicketUseCase;

  TicketCubit({required CreateTicketUseCase createTicketUseCase})
      : _createTicketUseCase = createTicketUseCase,
        super(TicketInitial());

  Future<void> createTicket({required CreateTicketEntity entity}) async {
    emit(CreateTicketLoading());
    final result = await _createTicketUseCase.call(entity);
    result.fold((l) {
      emit(
        const CreateTicketError(errorMessage: "Failed to create report"),
      );
    }, (r) {
      if (r.success) {
        emit(CreateTicketSuccess());
      } else {
        emit(const CreateTicketError(errorMessage: "Failed to create report"));
      }
    });
  }
}
