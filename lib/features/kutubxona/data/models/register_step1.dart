import '../../domain/entities/register_step1_entity.dart';

class RegisterStep1Model extends RegisterStep1Entity {
  RegisterStep1Model({
    required String phoneNumber,
    required String libraryId,
  }) : super(phoneNumber: phoneNumber, libraryId: libraryId);

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "library_id": libraryId,
    };
  }
}
