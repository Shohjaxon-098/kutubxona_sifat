import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_repository.dart';

class RegisterStep2UseCase {
  final RegisterRepository repository;

  RegisterStep2UseCase(this.repository);

  Future<Response> call(RegisterStep2Model user) {
    return repository.registerStep2(user);
  }
}
