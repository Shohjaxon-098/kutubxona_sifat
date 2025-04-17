// lib/features/register_step2/domain/usecases/submit_register_step2.dart
import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step2_repository.dart';


class SubmitRegisterStep2 {
  final RegisterStep2Repository repository;

  SubmitRegisterStep2(this.repository);

  Future<Either<Failure, void>> call(RegisterStep2Entity data) {
    return repository.submitStep2(data);
  }
}
