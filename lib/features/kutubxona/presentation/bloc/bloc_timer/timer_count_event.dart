abstract class TimerEvent {}

class TimerStarted extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int timeLeft;
  TimerTicked(this.timeLeft);
}

class TimerStopped extends TimerEvent {}