// domain/usecases/get_contributions.dart
import '../entities/contribution.dart';
import '../repositories/contribution_repository.dart';

class GetContributions {
  final ContributionRepository repository;

  GetContributions(this.repository);

  Future<Contribution> call(String libraryId) {
    return repository.getContributions(libraryId);
  }
}
