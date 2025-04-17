// lib/features/register_step2/presentation/bloc/register_step2_event.dart

import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';


abstract class RegisterStep2Event {}

class SubmitRegisterStep2Event extends RegisterStep2Event {
  final RegisterStep2Entity entity;

  SubmitRegisterStep2Event({required this.entity});
}
