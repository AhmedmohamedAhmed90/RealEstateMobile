import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/SignupCubit.dart';
import './cubit/SignupStates.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      body: BlocProvider(
        create: (context) => SignupCubit(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
                ),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                ),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                ),
                _buildTextField(
                  controller: _phoneNumberController,
                  labelText: 'Phone Number',
                  validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                ),
                _buildTextField(
                  controller: _firstNameController,
                  labelText: 'First Name',
                  validator: (value) => value!.isEmpty ? 'Please enter a first name' : null,
                ),
                _buildTextField(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  validator: (value) => value!.isEmpty ? 'Please enter a last name' : null,
                ),
                SizedBox(height: 30),
                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Successful')));
                    } else if (state is SignupFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(context).signup(
                            _usernameController.text,
                            _passwordController.text,
                            _emailController.text,
                            _phoneNumberController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Signup'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
