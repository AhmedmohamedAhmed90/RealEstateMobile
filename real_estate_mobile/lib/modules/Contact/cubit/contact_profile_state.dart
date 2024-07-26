import '../models/contact_profile_model.dart';

abstract class ContactProfileState {}

class ContactProfileInitial extends ContactProfileState {}

class ContactProfileLoading extends ContactProfileState {}

class ContactProfileLoaded extends ContactProfileState {
  final ContactProfile profile;
  ContactProfileLoaded(this.profile);
}

class ContactProfileError extends ContactProfileState {
  final String message;
  ContactProfileError(this.message);
}
