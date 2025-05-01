import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<BookEntity> books;

  const SearchLoaded(this.books);

  @override
  List<Object?> get props => [books];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
