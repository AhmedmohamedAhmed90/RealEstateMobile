// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:real_estate_mobile/modules/CustomerDataScreen/CustomerDataPage.dart';
// import 'package:real_estate_mobile/modules/MyPropertiesPage/MyPropertiesPage.dart';
// import '../CustomerDataScreen/CustomerDataRepository/CustomerDataRepository.dart';
// import '../CustomerDataScreen/cubit/CustomerDataCubit.dart';
// import './cubit/contact_profile_cubit.dart';
// import './cubit/contact_profile_state.dart';
// import './repository/contact_profile_repository.dart';
// import '../Login/LoginPage.dart'; // Import the LoginPage
// import '../../shared/components/CustomAppBar.dart';
// import '../../shared/appcubit/ThemeCubit.dart';

// class ContactProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
//       child: BlocBuilder<ThemeCubit, ThemeState>(
//         builder: (context, themeState) {
//           final isDarkMode = themeState is DarkThemeState;

//           return Scaffold(
//             appBar: CustomAppBar(
//               title: 'Profile',
//               onToggleTheme: () {
//                 final themeCubit = BlocProvider.of<ThemeCubit>(context);
//                 themeCubit.toggleTheme();
//               },
//             ),
//             body: BlocBuilder<ContactProfileCubit, ContactProfileState>(
//               builder: (context, state) {
//                 if (state is ContactProfileLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ContactProfileLoaded) {
//                   final customer = state.customer;

//                   // Debugging: Print customer data
//                   print('Customer data: ${customer}');

//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         // Avatar
//                         Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.all(16.0),
//                           child: CircleAvatar(
//                             radius: 50,
//                             backgroundImage: AssetImage('assets/images/UserIcon.png'), // Placeholder photo
//                             backgroundColor: Colors.grey[300],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(16.0),
//                           margin: const EdgeInsets.all(16.0),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 20),
//                                 Text(
//                                   'Hello ${customer?.firstName ?? ''} ${customer?.lastName ?? ''}!',
//                                   style: GoogleFonts.lato(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.titleLarge?.color,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   '${customer?.email ?? 'N/A'}',
//                                   style: GoogleFonts.lato(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.normal,
//                                     color: Theme.of(context).textTheme.bodyLarge?.color,
//                                   ),
//                                 ),
//                                 SizedBox(height: 20),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) => MyPropertiesPage(
//                                           properties: customer?.ownedProperties ?? [],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     'My Properties',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey[800],
//                                     minimumSize: Size(double.infinity, 50),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => BlocProvider(
//                                           create: (context) => CustomerDataCubit(CustomerDataRepository()),
//                                           child: CustomerDataPage(
//                                             firstName: customer?.firstName ?? 'N/A',
//                                             lastName: customer?.lastName ?? 'N/A',
//                                             phone: customer?.phoneNumber ?? 'N/A',
//                                             address: customer?.address ?? 'N/A',
//                                             customerid: customer?.id ?? 'N/A',
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     'My Info',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey[800],
//                                     minimumSize: Size(double.infinity, 50),
//                                   ),
//                                 ),
//                                 SizedBox(height: 20),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     BlocProvider.of<ContactProfileCubit>(context).logout();
//                                   },
//                                   child: Text(
//                                     'Logout',
//                                     style: TextStyle(color: Color.fromARGB(255, 232, 161, 46)),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Color.fromARGB(165, 0, 0, 0),
//                                     minimumSize: Size(double.infinity, 50),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (state is ContactProfileError) {
//                   return Center(child: Text(state.message));
//                 } else if (state is ContactProfileLogoutSuccess) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     Navigator.of(context).pushAndRemoveUntil(
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                       (Route<dynamic> route) => false,
//                     );
//                   });
//                 } else if (state is ContactProfileLogoutFailure) {
//                   return Center(child: Text(state.message));
//                 }
//                 return Center(child: Text('Press the button to fetch profile'));
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_mobile/modules/CustomerDataScreen/CustomerDataPage.dart';
import 'package:real_estate_mobile/modules/MyPropertiesPage/MyPropertiesPage.dart';
import '../CustomerDataScreen/CustomerDataRepository/CustomerDataRepository.dart';
import '../CustomerDataScreen/cubit/CustomerDataCubit.dart';
import '../Home/home_page.dart';
import '../QrCode/qr_code_page.dart';
import '../ServicesScreen/ServicesScreen.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';
import '../Login/LoginPage.dart'; // Import the LoginPage
import '../../shared/components/CustomAppBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';
import '../../shared/components/CustomBottomNavBar.dart'; // Import CustomBottomNavBar

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

                  return Column(
                    children: [
                      // Avatar and User Info
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/UserIcon.png'), // Placeholder photo
                              backgroundColor: Colors.grey[300],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Hello ${customer?.firstName ?? ''} ${customer?.lastName ?? ''}!',
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.titleLarge?.color,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${customer?.email ?? 'N/A'}',
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Card for My Properties
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyPropertiesPage(
                                          properties: customer?.ownedProperties ?? [],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.home, size: 30, color: Colors.grey[600]), // Adjusted size
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          'My Properties',
                                          style: GoogleFonts.lato(
                                            fontSize: 16, // Adjusted size
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).textTheme.bodyText1?.color,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]), // Adjusted size
                                    ],
                                  ),
                                ),
                                height: 55, // Reduced height
                              ),
                              SizedBox(height: 10),
                              // Card for My Info
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => CustomerDataCubit(CustomerDataRepository()),
                                          child: CustomerDataPage(
                                            firstName: customer?.firstName ?? 'N/A',
                                            lastName: customer?.lastName ?? 'N/A',
                                            phone: customer?.phoneNumber ?? 'N/A',
                                            address: customer?.address ?? 'N/A',
                                            customerid: customer?.id ?? 'N/A',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.info, size: 30, color: Colors.grey[600]), // Adjusted size
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          'My Info',
                                          style: GoogleFonts.lato(
                                            fontSize: 16, // Adjusted size
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).textTheme.bodyText1?.color,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]), // Adjusted size
                                    ],
                                  ),
                                ),
                                height: 55, // Reduced height
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Spacer to push Logout Button up
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), // Space from bottom
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<ContactProfileCubit>(context).logout();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 232, 161, 46),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            height: 60, // Match height of cards
                          ),
                        ),
                      )
                    ],
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
            bottomNavigationBar: CustomBottomNavBar(
              selectedIndex: 3, // Adjust this according to the selected index
              onTap: (index) {
                final pages = [
                  HomePage(),
                  ServicesScreen(),
                  QRCodePage(),
                  ContactProfilePage(),
                ];

                if (index >= 0 && index < pages.length) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => pages[index]),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
