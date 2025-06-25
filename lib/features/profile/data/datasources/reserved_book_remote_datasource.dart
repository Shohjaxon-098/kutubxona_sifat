import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/core/services/local_storage.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/profile/data/model/reserved_book_model.dart';

abstract class ReservedBookRemoteDataSource {
  Future<List<ReservedBookModel>> getReservedBooks(String libraryId);
}

class ReservedBookRemoteDataSourceImpl implements ReservedBookRemoteDataSource {
  final dio=DioClient().dio;

  ReservedBookRemoteDataSourceImpl();
  @override
  Future<List<ReservedBookModel>> getReservedBooks(String libraryId) async {
    final token = await LocalStorage.getAccessToken();
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/books/$libraryId/reserve-book/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data;

      if (data == null || data['results'] == null) {
        throw ServerException(message: 'Natija topilmadi');
      }

      final List<dynamic> results = data['results'];

      final List<ReservedBookModel> reservedBooks =
          results
              .map(
                (json) =>
                    ReservedBookModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();

      return reservedBooks;
    } catch (e, stackTrace) {
      log("Unknown error", error: e, stackTrace: stackTrace);
      throw ServerException(message: 'Noma’lum xatolik: $e');
    }
  }
}
