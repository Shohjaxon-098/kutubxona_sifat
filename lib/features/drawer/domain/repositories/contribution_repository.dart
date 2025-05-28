// domain/repositories/contribution_repository.dart
import '../entities/contribution.dart';

abstract class ContributionRepository {
  Future<Contribution> getContributions(String libraryId);
}
