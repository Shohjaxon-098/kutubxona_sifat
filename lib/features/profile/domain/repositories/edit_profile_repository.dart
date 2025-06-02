import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';

abstract class ProfileRepository {
  Future<void> updateProfile( EditProfileEntity entity);
}
