import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/Login/LoginPage.dart';
import 'modules/Contact/ContactPage.dart';
import 'modules/Splash/SplashScreen.dart';
import 'modules/QrCode/cubit/qr_code_cubit.dart';
import 'modules/QrCode/qr_code_page.dart';
import './modules/Home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QRCodeCubit>(
          create: (context) => QRCodeCubit(),
        ),
        // Add other providers if necessary
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 172, 155, 122),
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.black),
            headline2: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 172, 155, 122),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black.withOpacity(0.6),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
          ),
        ),
        themeMode: ThemeMode.system, // Automatically switch based on system settings
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/qr-code': (context) => QRCodePage(),
          '/home': (context) => HomePage(),
          // Define other routes here
        },
      ),
    );
  }
}
