import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCases loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginUseCase.call(
          LoginEntity(
            phoneNumber: event.phoneNumber,
            password: event.password,
            libraryId: event.libraryId,
          ),
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginError(message: e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}
