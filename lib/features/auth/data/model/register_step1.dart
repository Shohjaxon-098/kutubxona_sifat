import 'package:kutubxona/features/auth/domain/entities/register_step1_entity.dart';

class RegisterStep1Model extends RegisterStep1Entity {
  RegisterStep1Model({
    required super.phoneNumber,
    required super.libraryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "library_id": libraryId,
    };
  }
}
