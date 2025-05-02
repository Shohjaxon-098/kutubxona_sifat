// lib/features/register_step2/data/models/register_step2_model.dart

import 'package:kutubxona/features/auth/domain/entities/register_step2_entity.dart';

class RegisterStep2Model extends RegisterStep2Entity {
  RegisterStep2Model({
    required super.firstName,
    required super.lastName,
    required super.selectGender,
    required super.telegramUsername,
    required super.password,
    required super.birthDate,
    required super.documentType,
    required super.documentNumber,
    required super.documentFront,
    required super.documentBack,
    required super.libraryId,
    required super.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': selectGender,
      'telegram_username': telegramUsername,
      'password': password,
      'birth_date': birthDate,
      'verification_type': documentType,
      'document_number': documentNumber,
      'document_file1': documentFront,
      'document_file2': documentBack,
      'library': libraryId,
      'user': userId,
    };
  }
}
