// lib/features/register_step2/presentation/bloc/register_step2_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/register_step2_usecases.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_state.dart';

class RegisterStep2Bloc extends Bloc<RegisterStep2Event, RegisterStep2State> {
  final RegisterStep2Usecases submitUseCase;

  RegisterStep2Bloc(this.submitUseCase) : super(RegisterStep2Initial()) {
    on<SubmitRegisterStep2Event>((event, emit) async {
      emit(RegisterStep2Loading());
      try {
        await submitUseCase.call(
          RegisterStep2Entity(
            firstName: event.entity.firstName,
            lastName: event.entity.lastName,
            selectGender: event.entity.selectGender,
            password: event.entity.password,
            telegramUsername: event.entity.telegramUsername,
            birthDate: event.entity.birthDate,
            documentType: event.entity.documentType,
            documentNumber: event.entity.documentNumber,
            documentFront: event.entity.documentFront,
            documentBack: event.entity.documentBack,
            userId: event.entity.userId,
            libraryId: event.entity.libraryId,
          ),
        );
        emit(RegisterStep2Success());
      } catch (e) {
        emit(RegisterStep2Failure(e.toString()));
      }
    });
  }
}
