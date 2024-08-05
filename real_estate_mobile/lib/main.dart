// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'modules/Login/LoginPage.dart';
// // import 'modules/Contact/ContactPage.dart';
// import 'modules/Splash/SplashScreen.dart';
// // import 'modules/QrCode/cubit/qr_code_cubit.dart';
// import 'modules/QrCode/qr_code_page.dart';
// import '../../shared/appcubit/ThemeCubit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ThemeCubit(),
//       child: BlocBuilder<ThemeCubit, ThemeState>(
//         builder: (context, state) {
//           final isDarkMode = state is DarkThemeState;

//           return MaterialApp(
//             title: 'Al Dawlia',
//             theme: ThemeData(
//              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//               useMaterial3: true,
//               scaffoldBackgroundColor: Colors.white, // Light mode background
//             textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.black), // Light mode text color
//                 bodyMedium: TextStyle(color: Colors.black),
//                 titleLarge: TextStyle(color: Colors.black), // Use for titles, headers, etc.
//                 titleMedium: TextStyle(color: Colors.black),
//                 titleSmall: TextStyle(color: Colors.black),
//               ),
//             ),
//             darkTheme: ThemeData(
//             //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//               useMaterial3: true,
//               scaffoldBackgroundColor: Colors.black, // Dark mode background
//                 textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.white), // Dark mode text color
//                 bodyMedium: TextStyle(color: Colors.white),
//                 titleLarge: TextStyle(color: Colors.white), // Use for titles, headers, etc.
//                 titleMedium: TextStyle(color: Colors.white),
//                 titleSmall: TextStyle(color: Colors.white),
//               ),
//             ),
//             themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//             debugShowCheckedModeBanner: false,
//             home: SplashScreen(),
//             routes: {
//               '/qr-code': (context) => QRCodePage(),
//               // Define other routes here
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'modules/Login/LoginPage.dart';
// // import 'modules/Contact/ContactPage.dart';
// import 'modules/Splash/SplashScreen.dart';
// import 'modules/QrCode/cubit/qr_code_cubit.dart';
// import 'modules/QrCode/qr_code_page.dart';
// import '../../shared/appcubit/ThemeCubit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ThemeCubit(),
//       child: BlocBuilder<ThemeCubit, ThemeState>(
//         builder: (context, state) {
//           final isDarkMode = state is DarkThemeState;

//           return MaterialApp(
//             title: 'Al Dawlia',
//             theme: ThemeData(
//               useMaterial3: true,
//               scaffoldBackgroundColor: Colors.white, // Light mode background
//               textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.black), // Light mode text color
//                 bodyMedium: TextStyle(color: Colors.black),
//                 titleLarge: TextStyle(color: Colors.black), // Use for titles, headers, etc.
//                 titleMedium: TextStyle(color: Colors.black),
//                 titleSmall: TextStyle(color: Colors.black),
//               ),
//             ),
//             darkTheme: ThemeData(
//               useMaterial3: true,
//               scaffoldBackgroundColor: Colors.black, // Dark mode background
//               textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.white), // Dark mode text color
//                 bodyMedium: TextStyle(color: Colors.white),
//                 titleLarge: TextStyle(color: Colors.white), // Use for titles, headers, etc.
//                 titleMedium: TextStyle(color: Colors.white),
//                 titleSmall: TextStyle(color: Colors.white),
//               ),
//             ),
//             themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//             debugShowCheckedModeBanner: false,
//             home: SplashScreen(),
//             routes: {
//               '/qr-code': (context) => BlocProvider(
//                 create: (_) => QRCodeCubit(),
//                 child: QRCodePage(),
//               ),
//               // Define other routes here
//             },


            
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/Splash/SplashScreen.dart';
import 'modules/QrCode/cubit/qr_code_cubit.dart';
import 'modules/QrCode/qr_code_page.dart';
import '../../shared/appcubit/ThemeCubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDarkMode = state is DarkThemeState;

          return MaterialApp(
            title: 'Al Dawlia',
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white, // Light mode background
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black), // Light mode text color
                bodyMedium: TextStyle(color: Colors.black),
                titleLarge: TextStyle(color: Colors.black), // Use for titles, headers, etc.
                titleMedium: TextStyle(color: Colors.black),
                titleSmall: TextStyle(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.black, // Dark mode background
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white), // Dark mode text color
                bodyMedium: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white), // Use for titles, headers, etc.
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),
            ),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: {
              '/qr-code': (context) => BlocProvider(
                create: (_) => QRCodeCubit(),
                child: QRCodePage(),
              ),
              // Define other routes here
            },
          );
        },
      ),
    );
  }
}
