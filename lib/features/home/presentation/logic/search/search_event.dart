import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/home/domain/entities/filter_entity.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}
class SearchQueryChanged extends SearchEvent {
  final String query;
  final FilterEntity filters;

  SearchQueryChanged(this.query, this.filters);
}

