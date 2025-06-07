import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  late StreamSubscription _internetSubscription;

  InternetBloc() : super(InternetInitial()) {
    on<CheckInternetConnectionEvent>(_onCheckInitial);
    on<InternetStatusChangedEvent>(_onStatusChanged);

    _internetSubscription =
        InternetConnection().onStatusChange.listen((status) {
      add(InternetStatusChangedEvent(status == InternetStatus.connected));
    });
  }

  Future<void> _onCheckInitial(
      CheckInternetConnectionEvent event, Emitter<InternetState> emit) async {
    final hasConnection = await InternetConnection().hasInternetAccess;
    if (hasConnection) {
      emit(InternetConnected());
    } else {
      emit(InternetDisconnected());
    }
  }

  void _onStatusChanged(
      InternetStatusChangedEvent event, Emitter<InternetState> emit) {
    if (event.isConnected) {
      emit(InternetConnected());
    } else {
      emit(InternetDisconnected());
    }
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }
}
