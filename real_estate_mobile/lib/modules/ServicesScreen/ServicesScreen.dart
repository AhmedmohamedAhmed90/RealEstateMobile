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
                                builder: (BuildContext context) {
                                  return TicketForm(
                                    serviceId: service.id,
                                    onSuccess: () {
                                      BlocProvider.of<ServicesCubit>(context).fetchServices();
                                    },
                                  );
                                },
                              );
                            },
                            child: Card(
                              elevation: 4.0,
                              margin: EdgeInsets.all(8.0),
                              color: Color(0xFF1F7EEB), // Blue color
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Photo at the top of the card
                                  Container(
                                    width: double.infinity,
                                    height: 120.0, // Adjust height as needed
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(service.photo),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                                    ),
                                  ),
                                  // Service name below the photo
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Name: ${service.name}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // Text color
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: state.services.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75, // Adjust to fit the card content
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
