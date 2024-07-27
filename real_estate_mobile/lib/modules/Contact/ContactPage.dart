import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';
import '../ServicePage/ServicePage.dart';

class ContactProfilePage extends StatefulWidget {
  @override
  _ContactProfilePageState createState() => _ContactProfilePageState();
}

class _ContactProfilePageState extends State<ContactProfilePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    ContactProfileContent(),
    ServicePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build, color: Colors.green),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code, color: Colors.red),
            label: 'QR Generator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ContactProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
      child: BlocBuilder<ContactProfileCubit, ContactProfileState>(
        builder: (context, state) {
          if (state is ContactProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ContactProfileLoaded) {
            final profile = state.profile;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      profile.userName,
                      style: GoogleFonts.robotoMono(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Compound: ${profile.compoundName}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Unit: ${profile.unitName}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Unit Cost: \$${profile.unitCost}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Next Installment Due: ${profile.nextInstallmentDueDate.toLocal()}'.split(' ')[0],
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Next Installment Amount: \$${profile.nextInstallmentAmount}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ContactProfileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press the button to fetch profile'));
        },
      ),
    );
  }
}
