import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';

class UpdateProfileModel extends EditProfileEntity {
  UpdateProfileModel({
    required String? firstName,
    required String? lastName,
    required String gender,
    String? telegramUsername,
    required String password,
    String? birthDate,
    String? documentNumber,
    int? documentFile1,
    int? documentFile2,
    int? photo,
    String? verificationType,
  }) : super(
         firstName: firstName,
         lastName: lastName,
         gender: gender,
         telegramUsername: telegramUsername,
         password: password,
         birthDate: birthDate,
         documentNumber: documentNumber,
         documentFile1: documentFile1,
         documentFile2: documentFile2,
         photo: photo,
         verificationType: verificationType,
       );

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'telegram_username': telegramUsername,
      'password': password,
      'birth_date': birthDate,
      'document_number': documentNumber,
      'document_file1': documentFile1,
      'document_file2': documentFile2,
      'photo': photo,
      'verification_type': verificationType,
    };
  }
}
