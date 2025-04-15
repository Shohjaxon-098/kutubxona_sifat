import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/register_step1_repository.dart';
import 'package:kutubxona/service/api_service.dart';
import 'package:kutubxona/service/base_url.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl({required this.apiService});
  @override
  Future<Response> registerStep1(RegisterStep1 userData) async {
    return apiService.registerStep1(userData);
  }
}
