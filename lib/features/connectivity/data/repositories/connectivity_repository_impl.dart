import '../../domain/repositories/connectivity_repository.dart';
import '../datasources/connectivity_data_source.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final ConnectivityDataSource dataSource;
  ConnectivityRepositoryImpl(this.dataSource);

  @override
  Stream<bool> watchConnection() => dataSource.connectionStream.distinct();
}
