import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../utils/app_constants.dart';

class CustomerDataRepository {

  Future<void> updateCustomerData(String firstName, String lastName, String phoneNumber, String address,String password,String customerid) async {
    final response = await http.put(
      Uri.parse('$baseURL/customers/updatecustomer/$customerid'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': address,
        'password':password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update customer data');
    }
  }
}
