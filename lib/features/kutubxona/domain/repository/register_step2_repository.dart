// lib/features/register_step2/domain/repositories/register_step2_repository.dart

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import '../entities/register_step2_entity.dart';

abstract class RegisterStep2Repository {
  Future<Either<Failure, void>> submitStep2(RegisterStep2Entity data);
}
