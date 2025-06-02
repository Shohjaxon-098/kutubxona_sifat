import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/data/model/deficient_book_model.dart';

abstract class DeficientBooksRemoteDataSource {
  Future<List<DeficientBookModel>> getDeficientBooks();
}

class DeficientBooksRemoteDataSourceImpl
    implements DeficientBooksRemoteDataSource {
  final dio = DioClient().dio;

  @override
  Future<List<DeficientBookModel>> getDeficientBooks() async {
    final response = await dio.get(
      '${AppConfig.baseUrl}/books/${AppConfig.libraryId}/deficient-books/',
    );
    print(response.data);
    final results = response.data['results'] as List;
    return results.map((e) => DeficientBookModel.fromJson(e)).toList();
  }
}
