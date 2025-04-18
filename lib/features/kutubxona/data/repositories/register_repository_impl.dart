// lib/features/register_step2/data/repositories/register_step2_repository_impl.dart

import 'package:kutubxona/features/kutubxona/data/datasources/register_step2_remote_datasources.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step2_repository.dart';

import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';

class RegisterStep2RepositoryImpl implements RegisterStep2Repository {
  final RegisterStep2RemoteDataSource remoteDataSource;

  RegisterStep2RepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitRegisterStep2(RegisterStep2Entity entity) async {
    final model = RegisterStep2Model(
      firstName: entity.firstName,
      lastName: entity.lastName,
      selectGender: entity.selectGender,
      password: entity.password,
      telegramId: entity.telegramId,
      birthDate: entity.birthDate,
      documentType: entity.documentType,
      documentNumber: entity.documentNumber,
      documentFile1Path: entity.documentFile1Path,
      documentFile2Path: entity.documentFile2Path,
      libraryId: entity.libraryId
    );

    await remoteDataSource.submitRegisterStep2(model);
  }
}
