import 'package:bloc/bloc.dart';
import '../../../models/contact_profile_model.dart';
import '../repository/contact_profile_repository.dart';
import 'contact_profile_state.dart';

class ContactProfileCubit extends Cubit<ContactProfileState> {
  final ContactProfileRepository repository;

  ContactProfileCubit(this.repository) : super(ContactProfileInitial());

  void fetchProfile() async {
    try {
      emit(ContactProfileLoading());
      final profile = await repository.fetchContactProfile();
      emit(ContactProfileLoaded(profile));
    } catch (e) {
      emit(ContactProfileError('Failed to fetch profile'));
    }
  }
}
