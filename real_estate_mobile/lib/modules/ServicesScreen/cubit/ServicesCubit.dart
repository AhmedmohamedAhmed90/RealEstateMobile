import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate_mobile/models/ServicesModel.dart';

import '../../../utils/app_constants.dart';

part 'ServicesStates.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());

  final _storage = FlutterSecureStorage();

  Future<void> fetchServices() async {
    emit(ServicesLoading());
    try {
      final token = await _storage.read(key: 'auth_token');

      final String? formattedToken = token != null ? 'Bearer $token' : null;

      final response = await http.get(
        Uri.parse('${baseURL}/settings/getallservices'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          if (formattedToken != null) 'Authorization': formattedToken,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Services> services = responseData.map((data) => Services.fromJson(data)).toList();
        emit(ServicesSuccess(services: services));
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String error = responseData['message'] ?? 'An unknown error occurred';
        emit(ServicesFailure(errorMessage: error));
      }
    } catch (e) {
      emit(ServicesFailure(errorMessage: 'An error occurred during fetch: $e'));
    }
  }
}
