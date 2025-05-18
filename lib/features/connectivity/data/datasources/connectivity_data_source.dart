import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityDataSource {
  Stream<bool> get connectionStream;
}

class ConnectivityDataSourceImpl implements ConnectivityDataSource {
  final _controller = StreamController<bool>.broadcast();

  ConnectivityDataSourceImpl() {
    Connectivity().onConnectivityChanged.listen((status) async {
      // Wi‑Fi / Mobile bo‘lishi internet bor degani emas → extra ping
      final hasInternet = await InternetConnectionChecker.createInstance().hasConnection;
      _controller.add(hasInternet);
    });
  }

  @override
  Stream<bool> get connectionStream => _controller.stream;
}
