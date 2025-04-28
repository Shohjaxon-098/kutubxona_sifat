import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> login(LoginEntity entity);
}
