import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<BookEntity> books;

  const CategoryLoadedState(this.books);

  @override
  List<Object?> get props => [books];
}

class CategoryErrorState extends CategoryState {
  final String message;

  const CategoryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
