import 'package:kutubxona/core/api_result.dart';


abstract class AuthRepository {
  Future<ApiResult> sendPhoneNumber(String phoneNumber);
}
