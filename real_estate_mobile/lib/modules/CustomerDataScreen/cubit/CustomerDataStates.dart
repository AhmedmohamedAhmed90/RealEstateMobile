import 'package:equatable/equatable.dart';

abstract class CustomerDataState extends Equatable {
  const CustomerDataState();

  @override
  List<Object?> get props => [];
}

class CustomerDataInitial extends CustomerDataState {}

class CustomerDataLoaded extends CustomerDataState {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
   final String password;

  const CustomerDataLoaded({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
     required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, phoneNumber, address,password];
}

class CustomerDataError extends CustomerDataState {
  final String message;

  const CustomerDataError(this.message);

  @override
  List<Object?> get props => [message];
}
