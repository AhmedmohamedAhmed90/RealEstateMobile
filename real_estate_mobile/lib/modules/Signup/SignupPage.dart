import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:real_estate_mobile/modules/Login/LoginPage.dart';
import './cubit/SignupCubit.dart';
import './cubit/SignupStates.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController(); // New Address Field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupCubit(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF5F5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please fill in the details below to create an account.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
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
                    _buildTextField(
                      controller: _addressController,
                      labelText: 'Address', // New Address Field
                      validator: (value) => value!.isEmpty ? 'Please enter an address' : null,
                    ),
                    SizedBox(height: 30),
                    BlocConsumer<SignupCubit, SignupState>(
                      listener: (context, state) {
                        if (state is SignupSuccess) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(state.successMessage)),
                          // );
                          FlutterToastr.show(state.successMessage, context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        } else if (state is SignupFailure) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(state.errorMessage)),
                          // );
                        FlutterToastr.show(state.errorMessage, context);

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
                                _firstNameController.text,
                                _lastNameController.text,
                                _phoneNumberController.text,
                                _emailController.text,
                                _addressController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 165, 128, 91),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 165, 128, 91),
                        ),
                        child: Text('Already have an account? Log in'),
                      ),
                    ),
                  ],
                ),
              ),
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
          labelStyle: TextStyle(color: Color.fromARGB(255, 165, 128, 91), fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Color.fromARGB(255, 165, 128, 91)),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
