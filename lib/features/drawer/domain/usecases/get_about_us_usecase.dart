import '../entities/about_us_entity.dart';
import '../repositories/about_us_repository.dart';

class GetAboutUsUseCase {
  final AboutUsRepository repository;

  GetAboutUsUseCase(this.repository);

  Future<AboutUsEntity> call() {
    return repository.getAboutUs();
  }
}
