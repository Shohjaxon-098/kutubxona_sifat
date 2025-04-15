abstract class TimerState {}

class TimerInitial extends TimerState {
  final int timeLeft;
  TimerInitial(this.timeLeft);
}

class TimerRunning extends TimerState {
  final int timeLeft;
  TimerRunning(this.timeLeft);
}

class TimerCompleted extends TimerState {}