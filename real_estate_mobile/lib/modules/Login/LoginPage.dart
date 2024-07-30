import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ServicePage/ServicePage.dart';
import '../ServicesScreen/ServicesScreen.dart';
import './cubit/LoginCubit.dart';
import '../Signup/SignupPage.dart';
import '../Home/home_page.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color(0xFF7038DB), // Purple color
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF1F7EEB)), // Blue color
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F7EEB)), // Blue color
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color(0xFF1F7EEB)), // Blue color
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F7EEB)), // Blue color
              ),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login Failed: ${state.errorMessage}'),
                    backgroundColor: Colors.red, // Error color
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  context.read<LoginCubit>().login(email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F7EEB), // Blue color
                ),
               child: Text(
    'Login',
    style: TextStyle(color: Colors.white),
  ),
              );
            },
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF7038DB), // Purple color
            ),
            child: Text('Don\'t have an account? Sign Up'),
          ),
        ],
      ),
    );
  }
}
