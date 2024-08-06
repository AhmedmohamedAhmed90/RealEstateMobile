import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Contact/ContactPage.dart';
import '../Home/home_page.dart';
import '../ServicesScreen/ServicesScreen.dart';
import '../QrCode/qr_code_page.dart';
import '../../shared/components/CustomBottomNavBar.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedNavIndex = 0;

  final List<String> _titles = ['Home', 'Services', 'QR Generator', 'Profile'];
  final List<Widget> _pages = [
    HomePage(),
    ServicesScreen(),
    QRCodePage(),
    ContactProfilePage(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          appBar: CustomAppBar(
            title: _titles[_selectedNavIndex],
            onToggleTheme: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          body: _pages[_selectedNavIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedNavIndex,
            onTap: (index) {
              _onNavItemTapped(index);
            },
          ),
        );
      },
    );
  }
}
