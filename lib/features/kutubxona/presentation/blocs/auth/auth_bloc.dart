import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/auth/auth_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/auth/auth_state.dart';
import 'package:kutubxona/service/api_service.dart';

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
