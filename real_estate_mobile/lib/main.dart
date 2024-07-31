import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/Login/LoginPage.dart';
import 'modules/Contact/ContactPage.dart';
import 'modules/Splash/SplashScreen.dart';
import 'modules/QrCode/cubit/qr_code_cubit.dart';
import 'modules/QrCode/qr_code_page.dart';

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
        title: 'Al Dawlia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/qr-code': (context) => QRCodePage(),
          // Define other routes here
        },
      ),
    );
  }
}
