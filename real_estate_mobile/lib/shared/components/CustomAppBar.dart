// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   CustomAppBar({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         title,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Color.fromARGB(255, 232, 161, 46),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(165, 0, 0, 0),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(10),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onToggleTheme; // Callback to handle theme toggle

  CustomAppBar({required this.title, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 232, 161, 46),
        ),
      ),
      backgroundColor: Color.fromARGB(165, 0, 0, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6), // Toggle icon
          onPressed: onToggleTheme,
          color: Color.fromARGB(255, 232, 161, 46), // Icon color
        ),
        SizedBox(width: 16), // Space between icon and edge
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

