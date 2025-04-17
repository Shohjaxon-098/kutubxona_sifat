import 'dart:io';

class RegisterStep2Model {
  final String firstName;
  final String lastName;
  final String password;
  final String telegramId;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final File documentFile1;
  final File documentFile2;
  RegisterStep2Model({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.telegramId,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.documentFile1,
    required this.documentFile2,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'telegramId': telegramId,
      'birthDate': birthDate,
      'documentType': documentType,
      'documentNumber': documentNumber,
      'document_file1': documentFile1,
      'document_file2': documentFile2,
    };
  }
}
