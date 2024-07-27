part of 'service_history_cubit.dart';

@immutable
abstract class TicketHistoryState {}

class TicketHistoryInitial extends TicketHistoryState {}

class TicketHistoryLoading extends TicketHistoryState {}

class TicketHistoryLoaded extends TicketHistoryState {
  final List<TicketHistory> ticketHistory;
  TicketHistoryLoaded(this.ticketHistory);
}

class TicketHistoryError extends TicketHistoryState {
  final String message;
  TicketHistoryError(this.message);
}
