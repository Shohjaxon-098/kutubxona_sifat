import 'dart:io';

class RegisterStep2Model {
  final String firstName;
  final String lastName;
  final String password;
  final String telegramId;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final File document_file1;
  final File document_file2;
  RegisterStep2Model({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.telegramId,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.document_file1,
    required this.document_file2,
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
      'document_file1': document_file1,
      'document_file2': document_file2,
    };
  }
}
