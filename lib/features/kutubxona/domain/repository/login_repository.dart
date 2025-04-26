import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<void> login(LoginEntity entity);
}
