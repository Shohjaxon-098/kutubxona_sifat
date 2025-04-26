// login_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/login_usecases.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecases loginUsecases;

  LoginBloc({required this.loginUsecases}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginUsecases.call(
          LoginEntity(
            phoneNumber: event.phoneNumber,
            password: event.password,
            libraryId: event.libraryId,
          ),
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
