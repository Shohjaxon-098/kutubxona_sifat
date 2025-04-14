import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final RegisterStep1 userData;

  AuthLoginEvent(this.userData);

  @override
  List<Object?> get props => [userData];
}
