// lib/features/register_step2/domain/usecases/submit_register_step2.dart

import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step2_repository.dart';

class RegisterStep2Usecases {
  final RegisterStep2Repository repository;

  RegisterStep2Usecases({required this.repository});

  Future<void> call(RegisterStep2Entity entity) async {
    await repository.submitRegisterStep2(entity);
  }
}
