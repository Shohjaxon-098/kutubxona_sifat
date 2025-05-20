import 'package:kutubxona/features/profile/data/model/user_profile_model.dart';
import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

abstract class UserProfileRepository {
  Future<UserProfileEntity> getUserProfile();
}
