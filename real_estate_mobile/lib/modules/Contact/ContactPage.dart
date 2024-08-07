import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_mobile/models/CustomerModel.dart';
import 'package:real_estate_mobile/modules/CustomerDataScreen/CustomerDataPage.dart';
import 'package:real_estate_mobile/modules/MyPropertiesPage/MyPropertiesPage.dart';
import '../CustomerDataScreen/CustomerDataRepository/CustomerDataRepository.dart';
import '../CustomerDataScreen/cubit/CustomerDataCubit.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';
import '../Login/LoginPage.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class ContactProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            body: BlocBuilder<ContactProfileCubit, ContactProfileState>(
              builder: (context, state) {
                if (state is ContactProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContactProfileLoaded) {

                  final customer = state.customer;
                  
                  return _buildProfileContent(context, customer, themeState);
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
                return const Center(child: Text('Press the button to fetch profile'));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, dynamic customer, ThemeState themeState) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(context, customer),
                  SizedBox(height: 32),
                  _buildThemeSwitch(context, themeState),
                  SizedBox(height: 32),
                  Text(
                    'Account',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProfileOption(
                  context,
                  icon: Icons.home_rounded,
                  title: 'My Properties',
                  onTap: () => _navigateToMyProperties(context, customer),
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.person_rounded,
                  title: 'My Info',
                  onTap: () => _navigateToMyInfo(context, customer),
                ),
                SizedBox(height: 32),
                _buildLogoutButton(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic customer) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: const AssetImage('assets/images/UserIcon.png'),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${customer?.firstName ?? ''} ${customer?.lastName ?? ''}',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${customer?.email ?? 'N/A'}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSwitch(BuildContext context, ThemeState themeState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dark Mode',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Switch(
          value: themeState is DarkThemeState,
          onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Theme.of(context).primaryColor),
            SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Theme.of(context).textTheme.bodyMedium?.color),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        'Logout',
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => BlocProvider.of<ContactProfileCubit>(context).logout(),
    );
  }

  void _navigateToMyProperties(BuildContext context, dynamic customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPropertiesPage(
          properties: customer?.ownedProperties ?? [],
        ),
      ),
    );
  }

  void _navigateToMyInfo(BuildContext context, dynamic customer) {
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
  }
}