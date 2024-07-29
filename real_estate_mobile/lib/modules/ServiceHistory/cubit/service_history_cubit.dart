import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/ticket_history_model.dart';

part 'service_history_state.dart';

class TicketHistoryCubit extends Cubit<TicketHistoryState> {
  TicketHistoryCubit() : super(TicketHistoryInitial());

  Future<void> fetchTicketHistory(String ticketId) async {
    emit(TicketHistoryLoading());
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/ticket/viewhistory/$ticketId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<TicketHistory> ticketHistory = data.map((json) => TicketHistory.fromJson(json)).toList();
        emit(TicketHistoryLoaded(ticketHistory));
      } else {
        emit(TicketHistoryError('Failed to load ticket history'));
      }
    } catch (e) {
      emit(TicketHistoryError(e.toString()));
    }
  }
}
