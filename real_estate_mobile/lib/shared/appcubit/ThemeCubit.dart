import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class LightThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
    unselectedWidgetColor:Colors.black45,
    cardColor: Colors.grey[300],
    secondaryHeaderColor: Color.fromRGBO(165, 128, 91, 1),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
        primaryColor: Color.fromRGBO(165, 128, 91, 1),
        scaffoldBackgroundColor: Color.fromRGBO(248, 248, 248, 1),
        appBarTheme: AppBarTheme(
          // color: Color.fromRGBO(165, 128, 91, 1),
          color: Color.fromRGBO(255, 255, 255, 1),
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color.fromRGBO(33, 37, 41, 1)),
          bodyMedium: TextStyle(color: Color.fromRGBO(33, 37, 41, 1)),
          bodySmall: TextStyle(color:  Color.fromRGBO(33, 37, 41, 1)),
          headlineSmall:TextStyle(color:  Color.fromRGBO(33, 37, 41, 1)),
          // titleLarge: TextStyle(color:  Color.fromRGBO(33, 37, 41, 1)),
           headlineMedium: TextStyle(color:  Color.fromRGBO(33, 37, 41, 1)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(165, 128, 91, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color.fromRGBO(165, 128, 91, 1),
              width: 2.0,
            ),
          ),
        ), bottomAppBarTheme: BottomAppBarTheme(color: Color.fromRGBO(248, 248, 248, 1)),
      );
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
    cardColor: Color.fromRGBO(165, 128, 91, 1),
    secondaryHeaderColor: Colors.white,
    unselectedWidgetColor: Colors.white60,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
        primaryColor: Color.fromRGBO(165, 128, 91, 1),
        scaffoldBackgroundColor: Color.fromRGBO(33, 37, 41, 1),
        appBarTheme: AppBarTheme(
          // color: Color.fromRGBO(165, 128, 91, 1),
          color: Color.fromRGBO(142, 139, 136, 1),
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),
          bodyMedium: TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),
          bodySmall: TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),
          titleLarge: TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),
          headlineMedium: TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),
           headlineSmall:TextStyle(color: Color.fromRGBO(248, 248, 248, 1)),

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(165, 128, 91, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color.fromRGBO(165, 128, 91, 1),
              width: 2.0,
            ),
          ),
        ), bottomAppBarTheme: BottomAppBarTheme(color: Color.fromRGBO(33, 37, 41, 1)),
      );
}

@immutable
abstract class ThemeState {
  ThemeData get themeData;
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState());

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }
}
