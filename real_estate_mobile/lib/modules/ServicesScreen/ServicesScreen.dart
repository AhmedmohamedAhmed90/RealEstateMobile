import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_mobile/models/ServiceModel.dart';
import './cubit/ServicesCubit.dart';
import '../TicketForm/TicketForm.dart'; // Import the TicketForm widget

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Tickets'),
        backgroundColor: Color(0xFF7038DB),
      ),
      body: BlocProvider(
        create: (context) => ServicesCubit()..fetchServices(),
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ServicesSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final service = state.services[index];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => TicketForm(
                                  serviceId: service.id, // Adjust based on your ServiceModel
                                  onSuccess: () {
                                    Navigator.of(context).pop(); // Dismiss the dialog after success
                                  },
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4.0,
                              margin: EdgeInsets.all(4.0), // Reduced margin
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(service.photo),
                                    fit: BoxFit.cover, // Image covers the card
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: state.services.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Adjusted for smaller cards
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 1, // Adjust aspect ratio if needed
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ServicesFailure) {
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
