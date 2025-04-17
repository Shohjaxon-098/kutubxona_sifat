// lib/features/register_step2/presentation/bloc/register_step2_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step2_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/register_step2_usecases.dart';
import 'register_step2_event.dart';
import 'register_step2_state.dart';
import 'package:kutubxona/core/error/failure.dart';

class RegisterStep2Bloc extends Bloc<RegisterStep2Event, RegisterStep2State> {
  final SubmitRegisterStep2 submitUseCase;

  RegisterStep2Bloc(RegisterStep2Repository repo)
      : submitUseCase = SubmitRegisterStep2(repo),
        super(RegisterStep2Initial()) {
    on<RegisterStep2Submitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    RegisterStep2Submitted event,
    Emitter<RegisterStep2State> emit,
  ) async {
    emit(RegisterStep2Loading());
    final Either<Failure, void> result = await submitUseCase(event.data);
    result.fold(
      (failure) => emit(RegisterStep2Failure(failure.toString())),
      (_)       => emit(RegisterStep2Success()),
    );
  }
}
