import '../../domain/entities/statistic_entity.dart';
import '../../domain/repositories/statistic_repository.dart';
import '../datasources/statistic_remote_datasource.dart';

class StatisticRepositoryImpl implements StatisticRepository {
  final StatisticRemoteDataSource remoteDataSource;

  StatisticRepositoryImpl(this.remoteDataSource);

  @override
  Future<StatisticEntity> getStatistics(String libraryId) {
    return remoteDataSource.getStatistics(libraryId);
  }
}
