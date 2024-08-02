import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_mobile/modules/Home/home_page.dart';
import '../Login/LoginPage.dart';
import 'cubit/SplashCubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startSplashScreen(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
          
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is SplashInitial) {
            
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.network(
              'https://static.wixstatic.com/media/b0f6bb_4f5312b7bd154fcb84e4aa2de5003cd2~mv2.png/v1/crop/x_0,y_226,w_3486,h_1917/fill/w_194,h_106,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Al-Dawlia%20logo%2020230.png',
              width: 310,
              height: 170,
            ),
          ),
        ),
      ),
    );
  }
}
