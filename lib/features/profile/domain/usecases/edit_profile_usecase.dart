import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:kutubxona/features/profile/domain/repositories/edit_profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call( EditProfileEntity entity) {
    return repository.updateProfile( entity);
  }
}
