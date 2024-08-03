import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/app_constants.dart';

part 'LoginStates.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _storage = FlutterSecureStorage();

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('$baseURL/user/login'), 
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
        final String userid = responseData['userId'];

        await _storage.write(key: 'auth_token', value: token);
        await _storage.write(key: 'userid', value: userid);
        
        print('HTTP Response: ${response.statusCode} +Token Saved');
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
