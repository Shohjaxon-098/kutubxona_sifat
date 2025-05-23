import 'package:kutubxona/features/auth/data/datasources/login_remote_dara_sources.dart';
import 'package:kutubxona/features/auth/data/model/login_model.dart';

import 'package:kutubxona/features/auth/domain/entities/login_entity.dart';
import 'package:kutubxona/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDaraSources remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> login(LoginEntity entity) {
    final model = LoginModel(
      phoneNumber: entity.phoneNumber,
      password: entity.password,
      libraryId: entity.libraryId,
    );
    return remoteDataSource.login(model);
  }
}
