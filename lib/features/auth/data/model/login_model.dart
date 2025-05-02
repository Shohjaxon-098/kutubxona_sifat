import 'package:kutubxona/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.phoneNumber,
    required super.password,
    required super.libraryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "password": password,
      "library_id": libraryId,
    };
  }
}
