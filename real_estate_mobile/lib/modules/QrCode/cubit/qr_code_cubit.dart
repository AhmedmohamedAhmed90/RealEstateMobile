import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_constants.dart';

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
        Uri.parse('${baseURL}/user/generate-qr'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          if (formattedToken != null) 'Authorization': formattedToken,
        },
        body: jsonEncode({'visitorName': visitorName}),
      );

      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String fullQrCode = responseData['qrCode'];
      
      // Extract the base64 part of the QR code
      final String qrCode = fullQrCode.split(',')[1];
      
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

  static Future<void> shareQRCode(String qrCode) async {
  try {
    // Create a temporary file to store the QR code image
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/qr_code.png').create();
    await file.writeAsBytes(base64Decode(qrCode));

    // Share the file
    await Share.shareXFiles([XFile(file.path)], text: 'Here is your QR Code');
  } catch (e) {
    print('Error sharing QR code: $e');
    // You might want to show an error message to the user here
  }
}
}
