import 'package:kutubxona/features/profile/data/model/update_profile_model.dart';

class ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UpdateProfileModel model;
  UpdateProfile(this.model);
}