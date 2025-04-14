import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/service/apis/api_service.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegisterUserEvent) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<RegistrationState> _mapRegisterToState(RegisterUserEvent event) async* {
    try {
      yield RegistrationLoading();
      final response = await ApiService().registerStep2(event.userData);
      yield RegistrationSuccess(response);
    } catch (e) {
      yield RegistrationFailure(e.toString());
    }
  }
}
