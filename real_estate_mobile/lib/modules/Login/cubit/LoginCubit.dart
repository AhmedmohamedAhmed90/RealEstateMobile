import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'LoginStates.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      // Simulate a login API call
      await Future.delayed(Duration(seconds: 2));
      if (email == 'test@example.com' && password == 'password') {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errorMessage: 'Invalid email or password'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
