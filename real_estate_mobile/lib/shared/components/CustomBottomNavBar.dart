// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onTap;

//   CustomBottomNavBar({required this.selectedIndex, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ConvexAppBar(
//       style: TabStyle.reactCircle,
//       items: const [
//         TabItem(icon: Icons.home, title: 'Home'),
//         TabItem(icon: Icons.build, title: 'Services'),
//         TabItem(icon: Icons.qr_code, title: 'QR Generator'),
//         TabItem(icon: Icons.person, title: 'Profile'),
//       ],
//       initialActiveIndex: selectedIndex,
//       onTap: onTap,
//       backgroundColor: Color.fromARGB(163, 70, 70, 70),
//       activeColor: Color.fromARGB(255, 232, 161, 46),
//       color: Colors.grey,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart'; // Import the new package

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(161, 101, 97, 97), // Background color of the navbar
        borderRadius: BorderRadius.only(
          // topLeft: Radius.circular(20.0), // Radius for top-left corner
          // topRight: Radius.circular(20.0), // Radius for top-right corner
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -2), // Shadow position
          ),
        ],
      ),
      child: CustomLineIndicatorBottomNavbar(
        selectedColor: Color.fromARGB(255, 232, 161, 46),
        unSelectedColor: Color.fromARGB(160, 124, 118, 118),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set background color to transparent
        currentIndex: selectedIndex,
        onTap: onTap,
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Home',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Services',
            icon: Icons.build,
          ),
          CustomBottomBarItems(
            label: 'QR Generator',
            icon: Icons.qr_code,
          ),
          CustomBottomBarItems(
            label: 'Profile',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
