import '../entities/statistic_entity.dart';
import '../repositories/statistic_repository.dart';

class GetStatisticsUseCase {
  final StatisticRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<StatisticEntity> call(String libraryId) {
    return repository.getStatistics(libraryId);
  }
}
