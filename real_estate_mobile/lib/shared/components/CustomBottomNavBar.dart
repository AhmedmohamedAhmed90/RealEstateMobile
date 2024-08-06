import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.bottomAppBarTheme.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: CustomLineIndicatorBottomNavbar(
        selectedIconSize: 25,
        unselectedIconSize: 25,
        selectedFontSize: 12,
        selectedColor: theme.primaryColor,
        unSelectedColor: theme.unselectedWidgetColor,
        backgroundColor: theme.bottomAppBarTheme.color,
        currentIndex: selectedIndex,
        onTap: onTap,
        enableLineIndicator: false,
        lineIndicatorWidth: 2,
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
