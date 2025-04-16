import 'package:kutubxona/features/kutubxona/domain/repository/register_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step1_repository.dart';

import '../entities/register_step1_entity.dart';

class RegisterPhoneUseCase {
  final RegisterStep1Repository repository;

  RegisterPhoneUseCase(this.repository);

  Future<void> call(RegisterStep1Entity entity) {
    return repository.registerPhone(entity);
  }
}
