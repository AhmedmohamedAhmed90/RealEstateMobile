import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  final storage = FlutterSecureStorage();

  Future<void> fetchTickets() async {
    emit(TicketLoading());
    try {
      final userId = await storage.read(key: "userid");
      final response = await http.get(Uri.parse('http://127.0.0.1:5001/api/customers/customerdata/$userId'));
      if (response.statusCode == 200) {
        final customerData = json.decode(response.body);
        final customerId = customerData['customer'];
        final id = customerId['_id'];
        final ticketsResponse = await http.get(Uri.parse('http://127.0.0.1:5001/api/ticket/gettickets/$id'));

        if (ticketsResponse.statusCode == 200) {
          final tickets = json.decode(ticketsResponse.body);
          emit(TicketLoaded(tickets: tickets));
        } else {
          emit(TicketError(message: 'Failed to fetch tickets'));
        }
      } else {
        emit(TicketError(message: 'Failed to fetch customer data $userId'));
      }
    } catch (e) {
      emit(TicketError(message: e.toString()));
    }
  }
}
