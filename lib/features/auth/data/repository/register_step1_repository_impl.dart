import 'package:kutubxona/features/auth/data/datasources/register_step1_remote_datasource.dart';
import 'package:kutubxona/features/auth/data/model/register_step1.dart';
import 'package:kutubxona/features/auth/domain/repository/register_step1_repository.dart';

import 'package:kutubxona/features/auth/domain/entities/register_step1_entity.dart';

class RegisterStep1RepositoryImpl implements RegisterStep1Repository {
  final RegisterStep1RemoteDataSource remoteDataSource;

  RegisterStep1RepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> registerPhone(RegisterStep1Entity entity) {
    final model = RegisterStep1Model(
      phoneNumber: entity.phoneNumber,
      libraryId: entity.libraryId,
    );
    return remoteDataSource.registerPhone(model);
  }
}
