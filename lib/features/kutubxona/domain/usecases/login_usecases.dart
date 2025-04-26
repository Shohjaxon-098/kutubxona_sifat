import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/login_repository.dart';

class LoginUsecases {
  final LoginRepository repository;

  LoginUsecases(this.repository);

  Future<void> call(LoginEntity entity) {
    return repository.login(entity);
  }
}
