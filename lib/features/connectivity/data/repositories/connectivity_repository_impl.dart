import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kutubxona/features/connectivity/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;

  ConnectivityRepositoryImpl(this._connectivity);

  @override
  Stream<bool> watchConnection() async* {
    // Boshlanishda hozirgi statusni tekshirish
    yield await InternetConnectionChecker.createInstance().hasConnection;

    // Keyingi signalarda internetni tekshirish
    await for (final _ in _connectivity.onConnectivityChanged) {
      final hasInternet =
          await InternetConnectionChecker.createInstance().hasConnection;
      yield hasInternet;
    }
  }
}
