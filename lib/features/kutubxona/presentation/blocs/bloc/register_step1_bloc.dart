import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step1_repository.dart';
import 'package:kutubxona/service/api_service.dart';

import 'register_step1_event.dart';
import 'register_step1_state.dart';

class RegisterStep1Bloc extends Bloc<RegisterStep1Event, RegisterStep1State> {
  RegisterStep1Bloc() : super(RegisterStep1Initial()) {
    on<RegisterStep1Submitted>(_onRegisterStep1Submitted);
  }

  Future<void> _onRegisterStep1Submitted(
    RegisterStep1Submitted event,
    Emitter<RegisterStep1State> emit,
  ) async {
    emit(RegisterStep1Loading());

    try {
      await ApiService().registerStep1(event.userData);
      emit(RegisterStep1Success());
    } on ServerException catch (e) {
      emit(RegisterStep1Error(e.message));
    } catch (e) {
      emit(RegisterStep1Error("Noma'lum xatolik: $e"));
    }
  }
}
