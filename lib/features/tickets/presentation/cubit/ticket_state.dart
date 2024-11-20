part of 'ticket_cubit.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class CreateTicketLoading extends TicketState {}

class CreateTicketSuccess extends TicketState {}

class CreateTicketError extends TicketState {
  final String errorMessage;
  const CreateTicketError({required this.errorMessage});
}
