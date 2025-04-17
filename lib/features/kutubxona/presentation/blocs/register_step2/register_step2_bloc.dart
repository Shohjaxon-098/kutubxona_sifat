// lib/features/register_step2/presentation/bloc/register_step2_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/register_step2_usecases.dart';
import 'register_step2_event.dart';
import 'register_step2_state.dart';

class RegisterStep2Bloc extends Bloc<RegisterStep2Event, RegisterStep2State> {
  final RegisterStep2Usecases submitUseCase;

  RegisterStep2Bloc({required this.submitUseCase})
    : super(RegisterStep2Initial()) {
    on<SubmitRegisterStep2Event>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitRegisterStep2Event event,
    Emitter<RegisterStep2State> emit,
  ) async {
    emit(RegisterStep2Loading());
    try {
      await submitUseCase(event.entity);
      emit(RegisterStep2Success());
    } catch (e) {
      emit(RegisterStep2Failure(e.toString()));
    }
  }
}
