import 'package:flutter/foundation.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String successMessage;

  SignupSuccess({required this.successMessage});
}

class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure({required this.errorMessage});
}
