import 'package:kutubxona/features/auth/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<void> login(LoginEntity entity);
}
