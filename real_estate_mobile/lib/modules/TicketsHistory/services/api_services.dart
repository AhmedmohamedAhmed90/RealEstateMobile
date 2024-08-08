import '../../../models/ticket_history_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'YOUR_API_BASE_URL';

  Future<List<Ticket>> getTickets() async {
    final response = await http.get(Uri.parse('$baseUrl/tickets'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Ticket.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<void> updateTicketStatus(String id, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tickets/$id'),
      body: json.encode({'status': status}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update ticket status');
    }
  }

  Future<void> deleteTicket(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tickets/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete ticket');
    }
  }
}