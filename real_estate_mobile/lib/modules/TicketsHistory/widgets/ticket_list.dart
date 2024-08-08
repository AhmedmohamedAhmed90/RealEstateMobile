import 'package:flutter/material.dart';

class TicketListItem extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketListItem({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(ticket['description']),
        subtitle: Text('Status: ${ticket['status']}'),
      ),
    );
  }
}
