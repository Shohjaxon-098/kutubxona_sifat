// lib/features/register_step2/data/models/register_step2_model.dart

import 'dart:io';

import 'package:dio/dio.dart';
import '../../domain/entities/register_step2_entity.dart';

class RegisterStep2Model extends RegisterStep2Entity {
  RegisterStep2Model({
    required String firstName,
    required String lastName,
    required String password,
    required String telegramId,
    required String birthDate,
    required String documentType,
    required String documentNumber,
    required File documentFile1Path,
    required File documentFile2Path,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          password: password,
          telegramId: telegramId,
          birthDate: birthDate,
          documentType: documentType,
          documentNumber: documentNumber,
          documentFile1Path: documentFile1Path,
          documentFile2Path: documentFile2Path,
        );

  FormData toFormData() {
    return FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'telegram_id': telegramId,
      'birth_date': birthDate,
      'document_type': documentType,
      'document_number': documentNumber,
      'document_file1':documentFile1Path,
      'document_file2': documentFile2Path,
    });
  }
}
