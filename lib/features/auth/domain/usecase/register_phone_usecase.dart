import 'package:kutubxona/features/auth/domain/repository/register_step1_repository.dart';

import 'package:kutubxona/features/auth/domain/entities/register_step1_entity.dart';

class RegisterPhoneUseCase {
  final RegisterStep1Repository repository;

  RegisterPhoneUseCase(this.repository);

  Future<void> call(RegisterStep1Entity entity) {
    return repository.registerPhone(entity);
  }
}
