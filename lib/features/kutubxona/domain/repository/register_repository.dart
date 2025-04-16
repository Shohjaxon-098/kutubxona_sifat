import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';

abstract class RegisterStep2Repository {
  Future<Response> registerStep2(RegisterStep2Model user);
}
