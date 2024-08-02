import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'SplashStates.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> startSplashScreen() async {
    emit(SplashLoading());

    String? token = await _storage.read(key: 'auth_token');

    await Future.delayed(Duration(seconds: 2));

    if (token != null) {
     
      emit(SplashLoaded());
    } else {
      
      emit(SplashInitial());
    }
  }
}
