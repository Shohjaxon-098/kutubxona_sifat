// lib/features/register_step2/domain/entities/register_step2_entity.dart

import 'dart:io';

class RegisterStep2Entity {
  final String firstName;
  final String lastName;
  final String selectGender;
  final String password;
  final String telegramId;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final File documentFile1Path;
  final File documentFile2Path;
  final String libraryId;
  final int userId;

  RegisterStep2Entity({
    required this.firstName,
    required this.lastName,
    required this.selectGender,
    required this.password,
    required this.telegramId,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.documentFile1Path,
    required this.documentFile2Path,
    required this.libraryId,
    required this.userId
  });
}
