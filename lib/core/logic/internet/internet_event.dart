abstract class InternetEvent {}

class CheckInternetConnectionEvent extends InternetEvent {}

class InternetStatusChangedEvent extends InternetEvent {
  final bool isConnected;
  InternetStatusChangedEvent(this.isConnected);
}
