import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerInitial(10)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerStopped>(_onTimerStopped);
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    _timer?.cancel(); // Eski taymerni to'xtatish
    emit(TimerRunning(10)); // Taymerni boshlash
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final timeLeft =
          (state is TimerRunning) ? (state as TimerRunning).timeLeft - 1 : 0;

      if (timeLeft >= 0) {
        add(TimerTicked(timeLeft));
      } else {
        timer.cancel();
        emit(TimerCompleted());
      }
    });
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.timeLeft));
  }

  void _onTimerStopped(TimerStopped event, Emitter<TimerState> emit) {
    _timer?.cancel(); // Taymerni to'xtatish
    emit(TimerInitial(10)); // Taymerni boshlang'ich holatga qaytarish
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Bloc tugaganda taymerni to'xtatish
    return super.close();
  }
}
