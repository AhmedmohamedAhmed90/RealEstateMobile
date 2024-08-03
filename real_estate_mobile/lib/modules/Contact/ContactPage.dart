import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';
import '../Login/LoginPage.dart'; // Import the LoginPage
import '../../shared/components/CustomAppBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class ContactProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is DarkThemeState;

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Profile',
              onToggleTheme: () {
                final themeCubit = BlocProvider.of<ThemeCubit>(context);
                themeCubit.toggleTheme();
              },
            ),
            body: BlocBuilder<ContactProfileCubit, ContactProfileState>(
              builder: (context, state) {
                if (state is ContactProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ContactProfileLoaded) {
                  final customer = state.customer;

                  // Debugging: Print customer data
                  print('Customer data: ${customer}');

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  '${customer?.firstName} ${customer?.lastName}',
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.titleLarge?.color,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Owned Properties:',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Display owned properties and their projects
                                if (customer!.ownedProperties.isNotEmpty)
                                  ...customer.ownedProperties.map((ownedProperty) {
                                    final property = ownedProperty.property;
                                    final projects = property.projects;

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    
                              
                                        Text(
                                          'ProPerty:${property.name}',
                                          
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                          ),
                                        ),

                                        SizedBox(height: 10),
                                        if (projects.isNotEmpty)
                                          ...projects.map((project) {
                                            return Text(
                                              'Project:${project.name}',
                                              
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                              ),
                                            );
                                          }).toList()
                                        else
                                          Text(
                                            'No projects available.',
                                            style: GoogleFonts.lato(
                                              fontSize: 16,
                                              color: Theme.of(context).textTheme.bodyLarge?.color,
                                            ),
                                          ),
                                        SizedBox(height: 20),
                                      ],
                                    );
                                  }).toList()
                                else
                                  Text(
                                    'No properties available.',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactProfileCubit>(context).logout();
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Color.fromARGB(255, 232, 161, 46)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(165, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ContactProfileError) {
                  return Center(child: Text(state.message));
                } else if (state is ContactProfileLogoutSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                } else if (state is ContactProfileLogoutFailure) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Press the button to fetch profile'));
              },
            ),
          );
        },
      ),
    );
  }
}
