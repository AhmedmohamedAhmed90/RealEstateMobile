import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_mobile/models/ServiceModel.dart';
import 'package:real_estate_mobile/modules/Contact/ContactPage.dart';
import 'package:real_estate_mobile/modules/Home/home_page.dart';
import 'package:real_estate_mobile/modules/QrCode/qr_code_page.dart';
import './cubit/ServicesCubit.dart';
import '../TicketForm/TicketForm.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/components/CustomBottomNavBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int _selectedNavIndex = 1; // Set initial index to 1 for ServicesScreen

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      ServicesScreen(),
      QRCodePage(),
      ContactProfilePage(),
    ];

    return BlocProvider(
      create: (context) => ServicesCubit()..fetchServices(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            // appBar: CustomAppBar(
            //   title: '',
            //   onToggleTheme: () {
            //     context.read<ThemeCubit>().toggleTheme();
            //   },
            // ),
            body: BlocBuilder<ServicesCubit, ServicesState>(
              builder: (context, state) {
                if (state is ServicesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ServicesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request a Service',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Divider(
                          color: Colors.black.withOpacity(0.5),
                          thickness: 1.5,
                        ),
                        SizedBox(height: 16.0),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: state.services.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                  elevation: 2,
                                  margin: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 6,
                                              offset: Offset(0, 4), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            service.photo,
                                            width: 80.0,
                                            height: 80.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          service.name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ServicesFailure) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return Center(child: Text('Unexpected state!'));
                }
              },
            ),
            // bottomNavigationBar: CustomBottomNavBar(
            //   selectedIndex: _selectedNavIndex,
            //   onTap: (index) {
            //     _onNavItemTapped(index);
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => _pages[index]),
            //     );
            //   },
            // ),
          );
        },
      ),
    );
  }
}
