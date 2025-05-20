import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';
import 'package:kutubxona/features/profile/domain/repositories/user_profile_repository.dart';

class GetUserProfileUseCase {
  final UserProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserProfileEntity> call() async {
    return await repository.getUserProfile();
  }
}
