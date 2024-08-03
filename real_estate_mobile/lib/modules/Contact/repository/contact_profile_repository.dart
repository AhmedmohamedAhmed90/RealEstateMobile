// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../../models/CustomerModel.dart';
// import '../../../utils/app_constants.dart';

// class ContactProfileRepository {
//   final FlutterSecureStorage _storage = FlutterSecureStorage();

//   ContactProfileRepository();

//   Future<Customer?> fetchCustomerProfile(String userId) async {
//     final String? token = await _storage.read(key: 'auth_token');

//     if (token == null) {
//       throw Exception('No authentication token found.');
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('$baseURL/customers/customerdata/$userId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         if (data.containsKey('customer')) {
//           final Customer customer = Customer.fromJson(data['customer']);
//           return customer;
//         } else {
//           throw Exception('Invalid response structure: No customer data found.');
//         }
//       } else if (response.statusCode == 401) {
//         throw Exception('Unauthorized access - Please log in again.');
//       } else {
//         throw Exception('Failed to load customer profile: ${response.reasonPhrase}');
//       }
//     } catch (error) {
//       throw Exception('Error fetching customer profile: $error');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _storage.delete(key: 'auth_token');
//       await _storage.delete(key: 'userid');
//     } catch (e) {
//       throw Exception('Failed to logout: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/CustomerModel.dart';
import '../../../utils/app_constants.dart';

class ContactProfileRepository {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  ContactProfileRepository();

  Future<Customer?> fetchCustomerProfile(String userId) async {
    final String? token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('No authentication token found.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseURL/customers/customerdata/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('customer')) {
          final Customer customer = Customer.fromJson(data['customer']);
          return customer;
        } else {
          throw Exception('Invalid response structure: No customer data found.');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access - Please log in again.');
      } else {
        throw Exception('Failed to load customer profile: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Error fetching customer profile: $error');
    }
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'userid');
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
