// register_step1_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
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
      final result = await ApiService().registerStep1(event.userData);

      if (result.success) {
        emit(RegisterStep1Success());
      } else {
        emit(RegisterStep1Error("Telefon raqam noto‘g‘ri"));
      }
    } on DioException catch (e) {
      String errorMessage = "Xatolik yuz berdi";

      if (e.response?.statusCode == 400) {
        errorMessage = "Telefon raqam noto‘g‘ri";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Internetga ulanib bo‘lmadi";
      } else {
        errorMessage = e.response?.data ?? "Noma'lum xatolik";
      }

      emit(RegisterStep1Error(errorMessage));
    } catch (e) {
      emit(RegisterStep1Error("Noma'lum xatolik: $e"));
    }
  }
}
