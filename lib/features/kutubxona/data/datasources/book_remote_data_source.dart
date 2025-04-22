import 'package:kutubxona/core/util/important.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookModel>> getBooks() async {
    final id = await AppConfig.libraryId.toString();
    final response = await dio.get(
      '${AppConfig.baseUrl}/books/$id',
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Xatolik yuz berdi');
    }
  }
}
