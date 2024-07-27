import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'SplashStates.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplashScreen() {
    emit(SplashLoading());
    Future.delayed(Duration(seconds: 3), () {
      emit(SplashLoaded());
    });
  }
}
