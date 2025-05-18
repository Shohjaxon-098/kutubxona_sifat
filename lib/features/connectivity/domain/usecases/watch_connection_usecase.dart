import '../repositories/connectivity_repository.dart';

class WatchConnectionUseCase {
  final ConnectivityRepository repository;
  WatchConnectionUseCase(this.repository);

  Stream<bool> call() => repository.watchConnection();
}
