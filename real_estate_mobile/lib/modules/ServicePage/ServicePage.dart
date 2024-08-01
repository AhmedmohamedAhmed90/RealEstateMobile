import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/ServiceModel.dart';
import './cubit/ServiceCubit.dart';
import '../ServiceHistory/ServiceHistory.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services', style: TextStyle(fontWeight: FontWeight.bold ,color: Color.fromARGB(255, 232, 161, 46),)),
        backgroundColor: Color.fromARGB(165, 0, 0, 0), // Dark blue color
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ServiceCubit()..fetchTickets(),
        child: BlocBuilder<ServiceCubit, ServiceState>(
          builder: (context, state) {
            if (state is ServiceLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ServiceSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Ticket ticket = state.tickets[index];
                          return Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white, // Card background color
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Apartment No: ${ticket.apartmentNo}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF004F8B), // Dark blue color
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Service: ${ticket.serviceDetails}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[800], // Text color
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Category: ${ticket.categoryDetails}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[800], // Text color
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'SubCategory: ${ticket.subCategoryDetails}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[800], // Text color
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Description: ${ticket.description}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[800], // Text color
                                    ),
                                    maxLines: 2, // Limit number of lines
                                    overflow: TextOverflow.ellipsis, // Handle overflow
                                  ),
                                  Text(
                                    'Status: ${ticket.status}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: ticket.status == 'Completed' ? Colors.green : Colors.orange, // Status color
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TicketHistoryPage(ticketId: ticket.id),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF004F8B), // Button color
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'View Updates',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: state.tickets.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75, // Adjust to fit the card content
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ServiceFailure) {
              return Center(child: Text(state.errorMessage));
            } else {
              return Center(child: Text('Unexpected state!'));
            }
          },
        ),
      ),
    );
  }
}
