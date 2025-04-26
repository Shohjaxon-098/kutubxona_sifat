import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/home_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final result = await remoteDataSource.fetchCategories();
    return result
        .map(
          (model) =>
              CategoryEntity(id: model.id, name: model.name, icon: model.icon),
        )
        .toList();
  }

  @override
  Future<List<BookEntity>> getBooks() async {
    final result = await remoteDataSource.fetchBooks();
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
Future<Either<Failure, List<BookEntity>>> searchBooks(String query) async {
  try {
    final result = await remoteDataSource.fetchBooks(); // Assuming fetchBooks takes query
    final books = result
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
    return Right(books); // Return the list wrapped in Right if success
  } catch (e) {
    return Left(ServerFailure(e.toString())); // Return a failure if an error occurs
  }
}

}
