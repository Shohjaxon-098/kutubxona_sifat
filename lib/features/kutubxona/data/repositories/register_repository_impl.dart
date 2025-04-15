import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_repository.dart';
import 'package:kutubxona/service/api_service.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final ApiService apiService;

  RegisterRepositoryImpl(this.apiService);

  @override
  Future<Response> registerStep2(RegisterStep2Model user) {
    return apiService.registerStep2(user.toJson());
  }
}
