// lib/features/register_step2/data/datasources/register_step2_remote_data_source.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';

abstract class RegisterStep2RemoteDataSource {
  Future<void> submitStep2(RegisterStep2Model data);
}

class RegisterStep2RemoteDataSourceImpl implements RegisterStep2RemoteDataSource {
  final Dio dio;
  RegisterStep2RemoteDataSourceImpl(this.dio);

  @override
  Future<void> submitStep2(RegisterStep2Model data) async {
    final formData = FormData.fromMap({
      'first_name': data.firstName,
      'last_name': data.lastName,
      'password': data.password,
      'telegram_id': data.telegramId,
      'birth_date': data.birthDate,
      'document_type': data.documentType,
      'document_number': data.documentNumber,
      'document_file1': await MultipartFile.fromFile(data.documentFile1.path),
      'document_file2': await MultipartFile.fromFile(data.documentFile2.path),
    });
    await dio.post('/register/step2', data: formData);
  }
}
