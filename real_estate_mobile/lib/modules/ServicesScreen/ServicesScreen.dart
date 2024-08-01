import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_mobile/models/ServiceModel.dart';
import './cubit/ServicesCubit.dart';
import '../TicketForm/TicketForm.dart'; 
import '../../shared/components/CustomAppBar.dart'; 
import '../../shared/components/CustomBottomNavBar.dart'; 
import '../../shared/appcubit/ThemeCubit.dart'; 

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Service Tickets',
            onToggleTheme: () {
              
              final themeCubit = BlocProvider.of<ThemeCubit>(context);
              themeCubit.toggleTheme();
            },
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
                                      serviceId: service.id, 
                                      onSuccess: () {
                                        Navigator.of(context).pop(); 
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4.0,
                                  margin: EdgeInsets.all(4.0), 
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(service.photo),
                                        fit: BoxFit.cover, 
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: state.services.length,
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, 
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 1, 
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
      },
    );
  }
}
