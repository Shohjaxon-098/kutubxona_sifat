import 'package:kutubxona/features/kutubxona/enums/filter_type.dart';

abstract class BookSearchEvent {}

class SearchBooks extends BookSearchEvent {
  final String query;final FilterType filter;

  SearchBooks(this.query, {this.filter = FilterType.none});
  
}
