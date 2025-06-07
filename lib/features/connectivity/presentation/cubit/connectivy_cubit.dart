import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


class ConnectivityCubit extends Cubit<InternetStatus> {
  final Connectivity _connectivity;
  final InternetConnectionChecker _checker;

  ConnectivityCubit(this._connectivity, this._checker)
    : super(InternetStatus.connected) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _connectivity.onConnectivityChanged.listen((result) async {
      final hasConnection = await _checker.hasConnection;

      if (hasConnection) {
        emit(InternetStatus.connected);
      } else {
        emit(InternetStatus.disconnected);
      }
    });
  }
}
