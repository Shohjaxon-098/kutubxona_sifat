import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/auth/logic/bloc_timer/timer_count_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/auth/logic/bloc_timer/timer_count_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerInitial(10)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerStopped>(_onTimerStopped);
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) async {
    _timer?.cancel(); // Cancel any existing timer

    // Emit initial state before starting the timer
    emit(TimerRunning(10));

    // Use await to ensure that the event handler doesn't complete prematurely
    await Future.delayed(
      Duration(seconds: 1),
    ); // Delay before starting the timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final timeLeft =
          (state is TimerRunning) ? (state as TimerRunning).timeLeft - 1 : 0;

      if (timeLeft >= 0) {
        add(TimerTicked(timeLeft)); // Dispatch the TimerTicked event
      } else {
        timer.cancel();
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
