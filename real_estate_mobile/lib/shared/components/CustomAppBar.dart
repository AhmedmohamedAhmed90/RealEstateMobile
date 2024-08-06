import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onToggleTheme;

  CustomAppBar({required this.title, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image.asset(
          //   'assets/images/Al-Dawlialogo.webp', // Replace with your image path
          //   height: 80, // Adjust the height as needed
          // ),
          SizedBox(width: 8), // Spacing between the image and the title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 165, 128, 91),
            ),
          ),
        ],
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
          color: const Color.fromARGB(255, 165, 128, 91), // Color of the bottom border
          height: 1.0,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: onToggleTheme,
          color: Color.fromARGB(255, 165, 128, 91),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
