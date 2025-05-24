import 'package:kutubxona/features/profile/data/model/update_profile_model.dart';
import 'package:kutubxona/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(UpdateProfileModel model) {
    return repository.updateProfile(model);
  }
}
