import '../entities/register_step1_entity.dart';

abstract class RegisterStep1Repository {
  Future<void> registerPhone(RegisterStep1Entity entity);
}
