import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/CustomerModel.dart';
import '../repository/contact_profile_repository.dart';
import 'contact_profile_state.dart';

class ContactProfileCubit extends Cubit<ContactProfileState> {
  final ContactProfileRepository repository;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  ContactProfileCubit(this.repository) : super(ContactProfileInitial());

  Future<void> fetchProfile() async {
    emit(ContactProfileLoading());
    try {
      final String? userId ='66aa0cf81469b5e7daa6f304' ;//await _storage.read(key: 'userid');
      if (userId == null) {
        emit(ContactProfileError('User ID not found in secure storage.'));
        return;
      }

      final Customer? customer = await repository.fetchCustomerProfile(userId);
      if (customer != null) {
        // No need to fetch project details separately; they are included in customer data
        emit(ContactProfileLoaded(customer));
      } else {
        emit(ContactProfileError('Customer profile not found.'));
      }
    } catch (e) {
      emit(ContactProfileError('Failed to fetch profile: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    emit(ContactProfileLogoutInProgress());
    try {
      await repository.logout();
      emit(ContactProfileLogoutSuccess());
    } catch (e) {
      emit(ContactProfileLogoutFailure('Failed to log out: ${e.toString()}'));
    }
  }
}
