import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import '../../../utils/app_constants.dart';
import './SignupStates.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void signup(String username, String password, String email, String phoneNumber, String firstName, String lastName) async {
    emit(SignupLoading());
    try {
      // Prepare the request body
      final body = jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
      });

      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse('$baseURL/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check the response status
      if (response.statusCode == 200) {
        emit(SignupSuccess());
      } else {
        final errorResponse = jsonDecode(response.body);
        emit(SignupFailure(errorMessage: errorResponse['message'] ?? 'Signup failed'));
      }
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }
}
