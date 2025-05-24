import 'package:kutubxona/features/profile/data/model/update_profile_model.dart';

abstract class ProfileRepository {
  Future<void> updateProfile(UpdateProfileModel model);
}
