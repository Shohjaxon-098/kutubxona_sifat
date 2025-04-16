import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_repository.dart';
import 'package:kutubxona/service/api_service.dart';

class RegisterStep2RepositoryImpl implements RegisterStep2Repository {
  final ApiService apiService;

  RegisterStep2RepositoryImpl(this.apiService);

  @override
  Future<Response> registerStep2(RegisterStep2Model user) {
    return apiService.registerStep2(user.toJson());
  }
}
