// lib/features/register_step2/data/repositories/register_step2_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/register_step2_remote_datasources.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step2_repository.dart';
import '../../domain/entities/register_step2_entity.dart';


class RegisterStep2RepositoryImpl implements RegisterStep2Repository {
  final RegisterStep2RemoteDataSource remote;

  RegisterStep2RepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> submitStep2(RegisterStep2Entity data) async {
    try {
      await remote.submitStep2(data as dynamic); // data mos kelsin
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('asada'));
    }
  }
}
