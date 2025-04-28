import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecases loginUsecases;

  LoginBloc({required this.loginUsecases}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final loginEntity = LoginEntity(
      phoneNumber: event.phoneNumber,
      password: event.password,
      libraryId: event.libraryId,
    );

    final result = await loginUsecases.call(loginEntity);

    result.fold(
      (failure) => emit(LoginError(message: failure.message)), // ✅ to'g'ri
      (_) => emit(LoginSuccess()),
    );
  }
}
