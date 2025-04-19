// lib/features/register_step2/data/models/register_step2_model.dart


import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';

class RegisterStep2Model extends RegisterStep2Entity {
  RegisterStep2Model({
    required super.firstName,
    required super.lastName,
    required super.selectGender,
    required super.password,
    required super.telegramId,
    required super.birthDate,
    required super.documentType,
    required super.documentNumber,
    required super.documentFile1Path,
    required super.documentFile2Path,
    required super.libraryId,
    required super.userId,
  });

  FormData toFormData() {
    return FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'gender': selectGender,
      'password': password,
      'telegram_id': telegramId,
      'birth_date': birthDate,
      'document_type': documentType,
      'document_number': documentNumber,
      'document_file1': documentFile1Path,
      'document_file2': documentFile2Path,
      'library_id': libraryId,
      'user_id': userId,
    });
  }
}
