import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/watch_connection_usecase.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final WatchConnectionUseCase _watchConnection;
  ConnectivityCubit(this._watchConnection) : super(ConnectivityStatus.online) {
    _watchConnection().listen((hasInternet) {
      emit(
        hasInternet ? ConnectivityStatus.online : ConnectivityStatus.offline,
      );
    });
  }
}
