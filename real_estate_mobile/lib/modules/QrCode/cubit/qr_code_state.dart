part of 'qr_code_cubit.dart';

@immutable
abstract class QRCodeState {}

class QRCodeInitial extends QRCodeState {}

class QRCodeLoading extends QRCodeState {}

class QRCodeGenerated extends QRCodeState {
  final String qrCode;

  QRCodeGenerated({required this.qrCode});
}

class QRCodeError extends QRCodeState {
  final String error;

  QRCodeError(this.error);
}
