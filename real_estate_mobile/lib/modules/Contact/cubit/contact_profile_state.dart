import '../../../models/CustomerModel.dart';

abstract class ContactProfileState {}

class ContactProfileInitial extends ContactProfileState {}

class ContactProfileLoading extends ContactProfileState {}

class ContactProfileLoaded extends ContactProfileState {
  final Customer? customer;
  ContactProfileLoaded(this.customer);
}

class ContactProfileError extends ContactProfileState {
  final String message;
  ContactProfileError(this.message);
}

class ContactProfileLogoutInProgress extends ContactProfileState {}

class ContactProfileLogoutSuccess extends ContactProfileState {}

class ContactProfileLogoutFailure extends ContactProfileState {
  final String message;
  ContactProfileLogoutFailure(this.message);
}
