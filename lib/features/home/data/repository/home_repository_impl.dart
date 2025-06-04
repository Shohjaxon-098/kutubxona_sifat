
import 'package:kutubxona/features/home/data/datasources/home_remote_data_source.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/home/domain/entities/category.dart';
import 'package:kutubxona/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories(String libraryId) async {
    final result = await remoteDataSource.fetchCategories(libraryId);
    return result
        .map(
          (model) =>
              CategoryEntity(id: model.id, name: model.name, icon: model.icon),
        )
        .toList();
  }


  @override
  Future<List<BookEntity>> getBooks({int? categoryId, String? year, List<int>? ratings}) async {
    final result = await remoteDataSource.fetchBooks(categoryId: categoryId);
    return result
        .map(
          (model) => BookEntity(
            id: model.id,
            name: model.name,
            author: model.author,
            image: model.image,
            slug: model.slug,
            publishedDate: model.publishedDate,
            rating: model.rating,
            reviewsCount: model.reviewsCount,
            category: model.category,
            publication: model.publication,
          ),
        )
        .toList();
  }

  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    try {
      final result =
          await remoteDataSource
              .fetchBooks(); // Assuming fetchBooks takes query
      final books =
          result
              .map(
                (model) => BookEntity(
                  id: model.id,
                  name: model.name,
                  author: model.author,
                  image: model.image,
                  slug: model.slug,
                  publishedDate: model.publishedDate,
                  rating: model.rating,
                  reviewsCount: model.reviewsCount,
                  category: model.category,
                  publication: model.publication,
                ),
              )
              .toList();
      return books; // Return the list wrapped in Right if success
    } catch (e) {
      throw Exception(e.toString()); // Return a failure if an error occurs
    }
  }
}
