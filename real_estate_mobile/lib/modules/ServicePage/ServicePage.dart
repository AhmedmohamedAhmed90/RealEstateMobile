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
        title: Text('Service Tickets'),
        backgroundColor: Color(0xFF7038DB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
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
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Ticket ticket = state.tickets[index];
                          return Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            color: Color(0xFF1F7EEB), // Blue color
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Apartment No: ${ticket.apartmentNo}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, // Text color
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Service: ${ticket.serviceDetails}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white, // Text color
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Category: ${ticket.categoryDetails}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white, // Text color
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'SubCategory: ${ticket.subCategoryDetails}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white, // Text color
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          'Description: ${ticket.description}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white, // Text color
                                          ),
                                          maxLines: 2, // Limit number of lines
                                          overflow: TextOverflow.ellipsis, // Handle overflow
                                        ),
                                        Text(
                                          'Status: ${ticket.status}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white, // Text color
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: state.tickets.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.0, // Adjust to fit the card content
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
