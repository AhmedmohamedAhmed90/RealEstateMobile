// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:real_estate_mobile/models/ServiceModel.dart';

// part 'ServiceStates.dart';

// class ServiceCubit extends Cubit<ServiceState> {
//   ServiceCubit() : super(ServiceInitial());

//   final _storage = FlutterSecureStorage();

//   Future<void> fetchTickets() async {
//     emit(ServiceLoading());
//     try {
//       final token = await _storage.read(key: 'auth_token');
//       final response = await http.get(
//         Uri.parse('http://10.0.2.2:5001/api/ticket/'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = jsonDecode(response.body);
//         final tickets = responseData.map((data) => Ticket.fromJson(data)).toList();
//         emit(ServiceSuccess(tickets: tickets));
//       } else {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         final String error = responseData['error'];
//         emit(ServiceFailure(errorMessage: error));
//       }
//     } catch (e) {
//       emit(ServiceFailure(errorMessage: 'An error occurred during fetch: $e'));
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate_mobile/models/ServiceModel.dart';

import '../../../utils/app_constants.dart';

part 'ServiceStates.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());

  final _storage = FlutterSecureStorage();

  Future<void> fetchTickets() async {
    emit(ServiceLoading());
    try {
      final token = await _storage.read(key: 'auth_token');

      // Ensure token is correctly formatted with 'Bearer ' prefix
      final String? formattedToken = token != null ? '$token' : null;

      final response = await http.get(
        Uri.parse('${baseURL}/ticket/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          if (formattedToken != null) 'Authorization': formattedToken,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final tickets = responseData.map((data) => Ticket.fromJson(data)).toList();
        emit(ServiceSuccess(tickets: tickets));
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String error = responseData['message'] ?? 'An unknown error occurred';
        emit(ServiceFailure(errorMessage: error));
      }
    } catch (e) {
      emit(ServiceFailure(errorMessage: 'An error occurred during fetch: $e'));
    }
  }
}

