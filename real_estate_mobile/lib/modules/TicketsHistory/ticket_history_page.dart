import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/ticket_cubit.dart';
import './widgets/ticket_list.dart';
import './widgets/search_bar.dart';

class TicketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Management'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: BlocProvider(
        create: (_) => TicketCubit()..fetchTickets(),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<TicketCubit, TicketState>(
                builder: (context, state) {
                  if (state is TicketLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TicketLoaded) {
                    return ListView.builder(
                      itemCount: state.tickets.length,
                      itemBuilder: (context, index) {
                        return TicketListItem(ticket: state.tickets[index]);
                      },
                    );
                  } else if (state is TicketError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
