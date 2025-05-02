// presentation/bloc/otp/otp_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:kutubxona/features/auth/presentation/logic/otp/otp_event.dart';
import 'package:kutubxona/features/auth/presentation/logic/otp/otp_state.dart';
import 'package:kutubxona/features/auth/domain/entities/otp_entity.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyOtpUseCase useCase;

  OtpBloc(this.useCase) : super(OtpInitial()) {
    on<SubmitOtp>((event, emit) async {
      emit(OtpLoading());
      try {
        await useCase.call(
          OtpEntity(
            phoneNumber: event.phoneNumber,
            libraryId: event.libraryId,
            otp: event.otp,
          ),
        );
        emit(OtpSuccess());
      } catch (e) {
        emit(OtpFailure(e.toString()));
      }
    });
  }
}
