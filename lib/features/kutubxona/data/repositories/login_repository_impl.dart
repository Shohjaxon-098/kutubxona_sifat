import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/core/error/failure.dart';

import 'package:kutubxona/features/kutubxona/data/datasources/login_remote_dara_sources.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/login_repository.dart';
import 'package:kutubxona/features/kutubxona/data/models/login_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDaraSources remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> login(LoginEntity entity) async {
    final model = LoginModel(
      phoneNumber: entity.phoneNumber,
      password: entity.password,
      libraryId: entity.libraryId,
    );

    try {
      await remoteDataSource.login(model);
      return const Right(null); // successful
    } on ServerException catch (e) {
      return Left(ServerFailure(message:  e.message));
    }
  }
}
