import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

abstract class SearchState extends Equatable {
  final String query;
  const SearchState(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchInitial extends SearchState {
  const SearchInitial() : super('');
}

class SearchLoading extends SearchState {
  const SearchLoading(String query) : super(query);
}

class SearchLoaded extends SearchState {
  final List<BookEntity> books;

  const SearchLoaded(this.books, ) : super('');

  @override
  List<Object?> get props => [books, query];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message, String query) : super(query);

  @override
  List<Object?> get props => [message, query];
}
