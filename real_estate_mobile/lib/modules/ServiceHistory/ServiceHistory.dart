import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/service_history_cubit.dart';

class TicketHistoryPage extends StatelessWidget {
  final String ticketId;

  TicketHistoryPage({required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket History'),
        backgroundColor: Color(0xFF7038DB), // Purple color
      ),
      body: BlocProvider(
        create: (context) => TicketHistoryCubit()..fetchTicketHistory(ticketId),
        child: BlocBuilder<TicketHistoryCubit, TicketHistoryState>(
          builder: (context, state) {
            if (state is TicketHistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TicketHistoryLoaded) {
              return ListView.builder(
                itemCount: state.ticketHistory.length,
                itemBuilder: (context, index) {
                  final history = state.ticketHistory[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(history.text),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${history.createdDate.toLocal()}'),
                          Text('By: ${history.createdBy}'),
                          Text('Status: ${history.status}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is TicketHistoryError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Unexpected state!'));
          },
        ),
      ),
    );
  }
}
