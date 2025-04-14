import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/service/apis/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<AuthState> _mapLoginToState(AuthLoginEvent event) async* {
    try {
      yield AuthLoading();
      // API so‘rovini yuborish
      final response = await ApiService().registerStep1(
        event.userData,
      ); // APIga qo‘ng‘iroq
      yield AuthSuccess(response); // O‘zgartirish
    } catch (e) {
      yield AuthFailure(e.toString());
    }
  }
}
