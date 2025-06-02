import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';

abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String libraryId;
  final EditProfileEntity entity;

  UpdateProfileEvent(this.libraryId, this.entity);
}
