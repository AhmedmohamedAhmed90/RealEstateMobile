// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:real_estate_mobile/modules/MyPropertiesPage/cubit/MyPropertiesCubit.dart';
// // import '../../models/OwnedPropertyModel.dart';
// // import '../../shared/components/CustomAppBar.dart'; // Adjust path as necessary
// // import '../../shared/components/CustomBottomNavBar.dart'; // Adjust path as necessary
// // import '../../shared/appcubit/ThemeCubit.dart';
// // import '../PaymentPlan/PaymentPlanPage.dart'; // Import your new page

// // class MyPropertiesPage extends StatefulWidget {
// //   final List<OwnedProperty> properties;

// //   MyPropertiesPage({required this.properties});

// //   @override
// //   _MyPropertiesPageState createState() => _MyPropertiesPageState();
// // }

// // class _MyPropertiesPageState extends State<MyPropertiesPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => MyPropertiesCubit()..loadProperties(widget.properties),
// //       child: Scaffold(
// //         appBar: CustomAppBar(
// //           title: 'My Properties',
// //           onToggleTheme: () {
// //             context.read<ThemeCubit>().toggleTheme();
// //           },
// //         ),
// //         body: BlocBuilder<MyPropertiesCubit, List<OwnedProperty>>(
// //           builder: (context, properties) {
// //             return ListView.builder(
// //               itemCount: properties.length,
// //               itemBuilder: (context, index) {
// //                 final ownedProperty = properties[index];
// //                 final property = ownedProperty.property;
// //                 final projects = property.projects;

// //                 return InkWell(
// //                   onTap: () {
// //                     // Navigate to PaymentPlanPage
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => PaymentPlanPage(property: property),
// //                       ),
// //                     );
// //                   },
// //                   child: Container(
// //                     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
// //                     padding: const EdgeInsets.all(8.0),
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey[200],
// //                       borderRadius: BorderRadius.circular(10),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black26,
// //                           blurRadius: 6,
// //                           offset: Offset(0, 4),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         // Property Photo
// //                         SizedBox(
// //                           width: 100,
// //                           height: 100,
// //                           child: property.propertyPhotos.isNotEmpty
// //                               ? Image.network(property.propertyPhotos[0])
// //                               : Image.network('https://butterflymx.com/wp-content/uploads/2022/07/asset-management-vs-property-management.jpg'),
// //                         ),
// //                         SizedBox(width: 16),
// //                         // Property and Project Names
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 property.name,
// //                                 style: GoogleFonts.lato(
// //                                   fontSize: 18,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               if (projects != null && projects.isNotEmpty)
// //                                 ...projects.map((project) {
// //                                   return Text(
// //                                     project.name,
// //                                     style: GoogleFonts.lato(
// //                                       fontSize: 16,
// //                                       color: Colors.grey[700],
// //                                     ),
// //                                   );
// //                                 }).toList()
// //                               else
// //                                 Text(
// //                                   'No projects available.',
// //                                   style: GoogleFonts.lato(
// //                                     fontSize: 16,
// //                                     color: Colors.grey[700],
// //                                   ),
// //                                 ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //         bottomNavigationBar: CustomBottomNavBar(
// //           selectedIndex: 1, // Adjust based on your navigation
// //           onTap: (index) {
// //             // Handle bottom navigation
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:real_estate_mobile/models/OwnedPropertyModel.dart';
// import 'package:real_estate_mobile/models/PaymentPlanModel.dart'; // Import your PaymentPlan model
// import '../../shared/components/CustomAppBar.dart'; // Adjust path as necessary
// import '../../shared/components/CustomBottomNavBar.dart'; // Adjust path as necessary
// import '../../shared/appcubit/ThemeCubit.dart';
// import '../PaymentPlan/PaymentPlan.dart';

// import 'cubit/MyPropertiesCubit.dart'; // Import the PaymentPlanPage

// class MyPropertiesPage extends StatefulWidget {
//   final List<OwnedProperty> properties;

//   MyPropertiesPage({required this.properties});

//   @override
//   _MyPropertiesPageState createState() => _MyPropertiesPageState();
// }

// class _MyPropertiesPageState extends State<MyPropertiesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MyPropertiesCubit()..loadProperties(widget.properties),
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: 'My Properties',
//           onToggleTheme: () {
//             context.read<ThemeCubit>().toggleTheme();
//           },
//         ),
//         body: BlocBuilder<MyPropertiesCubit, List<OwnedProperty>>(
//           builder: (context, properties) {
//             return ListView.builder(
//               itemCount: properties.length,
//               itemBuilder: (context, index) {
//                 final ownedProperty = properties[index];
//                 final property = ownedProperty.property;
//                 final paymentPlan = ownedProperty.paymentPlan;
//                 final projects = property.projects;

//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to PaymentPlanPage with payment plan details
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PaymentPlanPage(
//                           paymentPlan: paymentPlan, // Pass the PaymentPlan instance
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 6,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         // Property Photo
//                         SizedBox(
//                           width: 100,
//                           height: 100,
//                           child: property.propertyPhotos.isNotEmpty
//                               ? Image.network(property.propertyPhotos[0])
//                               : Image.network('https://butterflymx.com/wp-content/uploads/2022/07/asset-management-vs-property-management.jpg'),
//                         ),
//                         SizedBox(width: 16),
//                         // Property and Project Names
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 property.name,
//                                 style: GoogleFonts.lato(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               if (projects != null && projects.isNotEmpty)
//                                 ...projects.map((project) {
//                                   return Text(
//                                     project.name,
//                                     style: GoogleFonts.lato(
//                                       fontSize: 16,
//                                       color: Colors.grey[700],
//                                     ),
//                                   );
//                                 }).toList()
//                               else
//                                 Text(
//                                   'No projects available.',
//                                   style: GoogleFonts.lato(
//                                     fontSize: 16,
//                                     color: Colors.grey[700],
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/OwnedPropertyModel.dart';
import '../../shared/appcubit/ThemeCubit.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/components/CustomBottomNavBar.dart';

import '../PaymentPlan/PaymentPlan.dart';
import 'cubit/MyPropertiesCubit.dart';

class MyPropertiesPage extends StatefulWidget {
  final List<OwnedProperty> properties;

  MyPropertiesPage({required this.properties});

  @override
  _MyPropertiesPageState createState() => _MyPropertiesPageState();
}

class _MyPropertiesPageState extends State<MyPropertiesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPropertiesCubit()..loadProperties(widget.properties),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Properties',
          showBackButton: true, // Enable the back button
          onToggleTheme: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
        body: BlocBuilder<MyPropertiesCubit, List<OwnedProperty>>(
          builder: (context, properties) {
            return ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final ownedProperty = properties[index];
                final property = ownedProperty.property;
                final paymentPlan = ownedProperty.paymentPlan;
                final projects = property.projects;
                final isDarkMode = Theme.of(context).brightness == Brightness.dark;

                return GestureDetector(
                  onTap: () {
                    // Navigate to PaymentPlanPage with payment plan details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPlanPage(
                          paymentPlan: paymentPlan, // Pass the PaymentPlan instance
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Property Photo
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: property.propertyPhotos.isNotEmpty
                              ? Image.network(property.propertyPhotos[0])
                              : Image.network('https://butterflymx.com/wp-content/uploads/2022/07/asset-management-vs-property-management.jpg'),
                        ),
                        SizedBox(width: 16),
                        // Property and Project Names
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.name,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.black : Colors.black, // Force black color in both modes
                                ),
                              ),
                              if (projects != null && projects.isNotEmpty)
                                ...projects.map((project) {
                                  return Text(
                                    project.name,
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: isDarkMode ? Colors.black : Colors.grey[700], // Force black color in dark mode
                                    ),
                                  );
                                }).toList()
                              else
                                Text(
                                  'No projects available.',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: isDarkMode ? Colors.black : Colors.grey[700], // Force black color in dark mode
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        // bottomNavigationBar: CustomBottomNavBar(
        //   selectedIndex: 1, // Adjust based on your navigation
        //   onTap: (index) {
        //     // Handle bottom navigation
        //   },
        // ),
      ),
    );
  }
}

