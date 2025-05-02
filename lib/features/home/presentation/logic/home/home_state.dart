// lib/features/kutubxona/presentation/blocs/home/home_state.dart
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/home/domain/entities/category.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataLoaded extends HomeState {
  final List<CategoryEntity> categories;
  final List<BookEntity> books;

  HomeDataLoaded({required this.categories, required this.books});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
