import 'package:kutubxona/features/auth/domain/entities/login_entity.dart';
import 'package:kutubxona/features/auth/domain/repository/login_repository.dart';

class LoginUseCases {
  final LoginRepository repository;

  LoginUseCases(this.repository);

  Future<void> call(LoginEntity entity) {
    return repository.login(entity);
  }
}
