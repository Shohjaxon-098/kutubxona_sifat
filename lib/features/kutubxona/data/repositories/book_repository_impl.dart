import 'package:dio/dio.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';

import 'package:kutubxona/features/kutubxona/data/models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final Dio dio;

  BookRepositoryImpl(this.dio);

  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    final response = await dio.get(
      '$baseUrl/books/$libraryId/',
      queryParameters: {'query': query},
    );

    return (response.data as List).map((e) => BookModel.fromJson(e)).toList();
  }
}
