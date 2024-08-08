part of 'ticket_cubit.dart';

@immutable
abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<dynamic> tickets;

  TicketLoaded({required this.tickets});
}

class TicketError extends TicketState {
  final String message;

  TicketError({required this.message});
}
