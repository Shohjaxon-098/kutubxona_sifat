// register_step1_event.dart

import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';

abstract class RegisterStep1Event extends Equatable {
  const RegisterStep1Event();

  @override
  List<Object> get props => [];
}

class RegisterStep1Submitted extends RegisterStep1Event {
  final RegisterStep1 userData;

  const RegisterStep1Submitted(this.userData);

  @override
  List<Object> get props => [userData];
}
