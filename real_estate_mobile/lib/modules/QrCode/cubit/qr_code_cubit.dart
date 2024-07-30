import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'qr_code_state.dart';

class QRCodeCubit extends Cubit<QRCodeState> {
  final _storage = const FlutterSecureStorage();

  QRCodeCubit() : super(QRCodeInitial());

  Future<void> generateQRCode(String visitorName) async {
    emit(QRCodeLoading());
    try {
      final token = await _storage.read(key: 'auth_token');

      // Ensure token is correctly formatted with 'Bearer ' prefix
      final String? formattedToken = token != null ? '$token' : null;

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5001/api/user/generate-qr'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          if (formattedToken != null) 'Authorization': formattedToken,
        },
        body: jsonEncode({'visitorName': visitorName}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String qrCode = responseData['qrCode'];
        emit(QRCodeGenerated(qrCode: qrCode));
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String error = responseData['message'] ?? 'An unknown error occurred';
        emit(QRCodeError(error));
      }
    } catch (e) {
      emit(QRCodeError('An error occurred during QR code generation: $e'));
    }
  }
}
