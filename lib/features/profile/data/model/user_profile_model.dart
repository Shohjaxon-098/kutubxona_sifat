import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required String firstName,
    required String lastName,
    required String gender,
    required String telegramUsername,
    required String birthDate,
    required String documentNumber,
    required String verificationType,
    required String rating,
    required bool isVerified,
    required String phoneNumber,
    required String documentFile1Path,
    required String documentFile2Path,
    required String photoPath,
  }) : super(
         firstName: firstName,
         lastName: lastName,
         gender: gender,
         telegramUsername: telegramUsername,
         birthDate: birthDate,
         documentNumber: documentNumber,
         verificationType: verificationType,
         rating: rating,
         isVerified: isVerified,
         phoneNumber: phoneNumber,
         documentFile1Path: documentFile1Path,
         documentFile2Path: documentFile2Path,
         photoPath: photoPath,
       );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? '',
      telegramUsername: json['telegram_username'] ?? '',
      birthDate: json['birth_date'],
      documentNumber: json['document_number'] ?? '',
      verificationType: json['verification_type'] ?? '',
      rating: json['rating'] ?? '',
      isVerified: json['is_verified'] ?? false,
      phoneNumber: json['phone_number'] ?? '',
      documentFile1Path: json['document_file1_path'] ?? '',
      documentFile2Path: json['document_file2_path'] ?? '',
      photoPath: json['photo_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'telegram_username': telegramUsername,
      'birth_date': birthDate,
      'document_number': documentNumber,
      'verification_type': verificationType,
      'rating': rating,
      'is_verified': isVerified,
      'phone_number': phoneNumber,
      'document_file1_path': documentFile1Path,
      'document_file2_path': documentFile2Path,
      'photo_path': photoPath,
    };
  }
}
