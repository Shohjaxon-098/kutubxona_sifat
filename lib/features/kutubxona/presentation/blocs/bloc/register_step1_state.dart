import 'package:equatable/equatable.dart';

abstract class RegisterStep1State extends Equatable {
  const RegisterStep1State();

  @override
  List<Object?> get props => [];
}

class RegisterStep1Initial extends RegisterStep1State {}

class RegisterStep1Loading extends RegisterStep1State {}

class RegisterStep1Success extends RegisterStep1State {}

class RegisterStep1Error extends RegisterStep1State {
  final String message;

  const RegisterStep1Error(this.message);

  @override
  List<Object?> get props => [message];
}
