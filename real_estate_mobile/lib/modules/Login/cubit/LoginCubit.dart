import 'package:bloc/bloc.dart';
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
        Uri.parse('http://10.0.2.2:5001/api/user/login'), 
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

        // Store the token securely
        await _storage.write(key: 'auth_token', value: token);
        print('HTTP Response: ${response.statusCode} +doneeeeeeee');
        print(_storage.read(key: 'auth_token'));

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
}
