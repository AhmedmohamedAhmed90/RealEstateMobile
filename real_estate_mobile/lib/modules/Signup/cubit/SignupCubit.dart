import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import '../../../utils/app_constants.dart';
import './SignupStates.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void signup(String firstName, String lastName, String phoneNumber, String email, String address) async {
    emit(SignupLoading());
    try {
      // Prepare the request body
      final body = jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
      });

      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse('$baseURL/customers/createcustomer'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check the response status
      if (response.statusCode == 200) { 
        final successResponse = jsonDecode(response.body);
        emit(SignupSuccess(successMessage: successResponse['message']??'username and password are sent on your email' ));
      } else {
        final errorResponse = jsonDecode(response.body);
        emit(SignupFailure(errorMessage: errorResponse['error'] ?? 'Signup failed'));
      }
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }
}
