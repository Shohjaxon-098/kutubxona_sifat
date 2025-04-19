import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_books_usecase.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BookRepository> categories;
  HomeLoaded(this.categories);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}