import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_step2_event.dart';
import 'register_step2_state.dart';
import 'package:kutubxona/service/api_service.dart';

class RegisterStep2Bloc extends Bloc<RegisterStep2Event, RegisterStep2State> {
  final ApiService apiService;

  RegisterStep2Bloc(this.apiService) : super(RegisterStep2Initial()) {
    // MUHIM QISM: shu yerda event handler yozilmagan bo'lishi mumkin
    on<RegisterStep2Submitted>((event, emit) async {
      emit(RegisterStep2Loading());

      try {
        final response = await apiService.registerStep2(event.data.toJson());

        if (response.statusCode == 200) {
          emit(RegisterStep2Success());
        } else {
          emit(RegisterStep2Failure("Xatolik: ${response.statusMessage}"));
        }
      } catch (e) {
        emit(RegisterStep2Failure("Exception: $e"));
      }
    });
  }
}
