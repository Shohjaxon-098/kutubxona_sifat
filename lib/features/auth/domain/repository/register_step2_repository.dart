// lib/features/register_step2/domain/repositories/register_step2_repository.dart

import 'package:kutubxona/features/auth/domain/entities/register_step2_entity.dart';

abstract class RegisterStep2Repository {
  Future<void> submitRegisterStep2(RegisterStep2Entity entity);
}
