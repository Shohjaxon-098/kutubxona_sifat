// data/repositories/contribution_repository_impl.dart
import '../../domain/entities/contribution.dart';
import '../../domain/repositories/contribution_repository.dart';
import '../datasources/contribution_remote_data_source.dart';

class ContributionRepositoryImpl implements ContributionRepository {
  final ContributionRemoteDataSource remoteDataSource;

  ContributionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Contribution> getContributions(String libraryId) async {
    return remoteDataSource.fetchContributions(libraryId);
  }
}
