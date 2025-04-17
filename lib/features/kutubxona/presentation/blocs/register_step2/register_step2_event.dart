// lib/features/register_step2/presentation/bloc/register_step2_event.dart
import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';

abstract class RegisterStep2Event extends Equatable {
  @override List<Object?> get props => [];
}

class RegisterStep2Submitted extends RegisterStep2Event {
  final RegisterStep2Entity data;
  RegisterStep2Submitted(this.data);
  @override List<Object?> get props => [data];
}
