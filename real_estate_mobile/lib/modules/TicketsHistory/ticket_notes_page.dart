// // In pages/ticket_history_page.dart

// import 'package:flutter/material.dart';
// import '../models/ticket.dart';

// class TicketHistoryPage extends StatelessWidget {
//   final Ticket ticket;

//   const TicketHistoryPage({Key? key, required this.ticket}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ticket History'),
//       ),
//       body: ListView.builder(
//         itemCount: ticket.history.length,
//         itemBuilder: (context, index) {
//           final historyItem = ticket.history[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     historyItem.text,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Status: ${historyItem.status}'),
//                   Text('Date: ${historyItem.createdDate.toLocal()}'),
//                   Text('Created By: ${historyItem.createdBy}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }