// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import './cubit/contact_profile_cubit.dart';
// import './cubit/contact_profile_state.dart';
// import './repository/contact_profile_repository.dart';
// import '../ServicePage/ServicePage.dart';
// import '../QrCode/qr_code_page.dart';

// class ContactProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 232, 161, 46),)),
//           backgroundColor: Color.fromARGB(165, 0, 0, 0), // Dark blue color
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(30),
//             ),
//           ),
//         ),
//         body: BlocBuilder<ContactProfileCubit, ContactProfileState>(
//           builder: (context, state) {
//             if (state is ContactProfileLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is ContactProfileLoaded) {
//               final profile = state.profile;
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(16.0),
//                       margin: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               radius: 50,
//                               backgroundImage: NetworkImage(profile.avatarUrl ?? ''),
//                               backgroundColor: Colors.deepPurple,
//                               child: profile.avatarUrl == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               profile.userName,
//                               style: GoogleFonts.lato(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF004F8B),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Compound: ${profile.compoundName}',
//                               style: GoogleFonts.lato(
//                                 fontSize: 18,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Unit: ${profile.unitName}',
//                               style: GoogleFonts.lato(
//                                 fontSize: 18,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Unit Cost: \$${profile.unitCost}',
//                               style: GoogleFonts.lato(
//                                 fontSize: 18,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                             // SizedBox(height: 10),
//                             // Text(
//                             //   'Next Installment Due: ${profile.nextInstallmentDueDate.toLocal()}'.split(' ')[0],
//                             //   style: GoogleFonts.lato(
//                             //     fontSize: 18,
//                             //     color: Colors.grey[700],
//                             //   ),
//                             // ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Next Installment Amount: \$${profile.nextInstallmentAmount}',
//                               style: GoogleFonts.lato(
//                                 fontSize: 18,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is ContactProfileError) {
//               return Center(child: Text(state.message));
//             }
//             return Center(child: Text('Press the button to fetch profile'));
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';
import '../ServicePage/ServicePage.dart';
import '../QrCode/qr_code_page.dart';
import '../../shared/components/CustomAppBar.dart'; 
import '../../shared/components/CustomBottomNavBar.dart';
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
                  final profile = state.profile;
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
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(profile.avatarUrl ?? ''),
                                  backgroundColor: Colors.deepPurple,
                                  child: profile.avatarUrl == null
                                      ? Icon(Icons.person, size: 50, color: Colors.white)
                                      : null,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  profile.userName,
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.titleLarge?.color,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Compound: ${profile.compoundName}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Theme.of(context).textTheme.bodyLarge?.color, 
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Unit: ${profile.unitName}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Theme.of(context).textTheme.bodyLarge?.color, 
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Unit Cost: \$${profile.unitCost}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Theme.of(context).textTheme.bodyLarge?.color, 
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Next Installment Amount: \$${profile.nextInstallmentAmount}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Theme.of(context).textTheme.bodyLarge?.color, 
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

