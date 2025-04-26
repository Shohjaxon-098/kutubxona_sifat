import 'package:equatable/equatable.dart';



abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAllHomeDataEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SearchBooksEvent extends HomeEvent {
  final String query;

  const SearchBooksEvent(this.query);

  @override
  List<Object?> get props => [query];
}



