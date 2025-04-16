import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/register_step1_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/register_phone_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step1/register_step1_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step1/register_step1_state.dart';

class RegisterStep1Bloc extends Bloc<RegisterStep1Event, RegisterStep1State> {
  final RegisterPhoneUseCase useCase;

  RegisterStep1Bloc(this.useCase) : super(RegisterInitial()) {
    // SHU QISMI MUHIM!
    on<SubmitPhoneNumber>((event, emit) async {
      emit(RegisterLoading());
      try {
        await useCase.call(RegisterStep1Entity(
          phoneNumber: event.phoneNumber,
          libraryId: event.libraryId,
        ));
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}