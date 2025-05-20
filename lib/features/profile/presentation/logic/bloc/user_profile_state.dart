import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfileEntity user;

  UserProfileLoaded(this.user);
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);

  @override
  String toString() => 'UserProfileError: $message';
}
