import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/ServiceModel.dart';
import './cubit/ServicesCubit.dart';

class ServicesScreen extends StatelessWidget {
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
                          return Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            color: Color.fromARGB(255, 151, 187, 228), // Blue color
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Photo at the top of the card
                                Container(
                                  width: double.infinity,
                                  height: 80.0, // Adjust height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(service.photo),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                                  ),
                                ),
                                // Service name below the photo
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     service.name ?? 'N/A',
                                //     style: TextStyle(
                                //       fontSize: 18.0,
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.white, // Text color
                                //     ),
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                        childCount: state.services.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
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
