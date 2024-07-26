import 'package:bloc/bloc.dart';
import './SignupStates.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void signup(String username, String password, String email, String phoneNumber, String firstName, String lastName) async {
    emit(SignupLoading());
    try {
      // Simulate a signup process
      await Future.delayed(Duration(seconds: 2));
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }
}
