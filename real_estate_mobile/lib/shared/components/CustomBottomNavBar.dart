import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.reactCircle,
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.build, title: 'Services'),
        TabItem(icon: Icons.qr_code, title: 'QR Generator'),
        TabItem(icon: Icons.person, title: 'Profile'),
      ],
      initialActiveIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: Color.fromARGB(165, 0, 0, 0),
      activeColor: Color.fromARGB(255, 232, 161, 46),
      color: Colors.grey,
    );
  }
}
