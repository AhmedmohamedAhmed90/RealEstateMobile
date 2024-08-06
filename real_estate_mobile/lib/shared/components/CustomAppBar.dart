import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onToggleTheme;

  CustomAppBar({required this.title, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Color.fromARGB(146, 232, 161, 46),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0), // No rounded corners for bottom
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0), // Height of the bottom border
        child: Container(
          color: const Color.fromARGB(255, 135, 134, 134), // Color of the bottom border
          height: 1.0,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: onToggleTheme,
          color: Color.fromARGB(255, 232, 161, 46),
        ),
        SizedBox(width: 16),
      ],
    );

    
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
