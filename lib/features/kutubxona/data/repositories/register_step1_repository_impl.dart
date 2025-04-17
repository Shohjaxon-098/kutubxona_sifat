import 'package:kutubxona/features/kutubxona/data/datasources/register_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step1_repository.dart';

import 'package:kutubxona/features/kutubxona/domain/entities/register_step1_entity.dart';


class RegisterStep1RepositoryImpl implements RegisterStep1Repository {
  final RegisterRemoteDataSource remoteDataSource;

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
