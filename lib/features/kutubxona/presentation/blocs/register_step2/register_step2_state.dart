// lib/features/register_step2/presentation/bloc/register_step2_state.dart
import 'package:equatable/equatable.dart';

abstract class RegisterStep2State extends Equatable {
  @override List<Object?> get props => [];
}

class RegisterStep2Initial extends RegisterStep2State {}
class RegisterStep2Loading extends RegisterStep2State {}
class RegisterStep2Success extends RegisterStep2State {}
class RegisterStep2Failure extends RegisterStep2State {
  final String message;
  RegisterStep2Failure(this.message);
  @override List<Object?> get props => [message];
}
