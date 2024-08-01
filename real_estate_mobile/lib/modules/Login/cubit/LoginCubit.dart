import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'LoginStates.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _storage = FlutterSecureStorage();

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5001/api/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        final Map<String, dynamic> user = responseData['user'];

        // Store the token and user ID securely
        await _storage.write(key: 'auth_token', value: token);
        await _storage.write(key: 'user_id', value: user['_id']);
        await _storage.write(key: 'user_name', value: user['username']);

        // Fetch and store the user data
        await fetchUserData(user['_id'], token);

        emit(LoginSuccess());
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String error = responseData['error'];
        emit(LoginFailure(errorMessage: error));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'An error occurred during login: $e'));
    }
  }

  Future<void> fetchUserData(String userId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5001/api/customers/customerdata/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> customer = responseData['customer'];
        final List<dynamic> ownedProperties = customer['ownedProperties'];
        if (kDebugMode) {
          print(ownedProperties);
        }
        // Store user data and owned properties securely
        await _storage.write(key: 'user_data', value: jsonEncode(customer));
        await _storage.write(key: 'owned_properties', value: jsonEncode(ownedProperties));
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String error = responseData['error'];
        print('Error fetching user data: $error');
      }
    } catch (e) {
      print('An error occurred during fetch user data: $e');
    }
  }
}
