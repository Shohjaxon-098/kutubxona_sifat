import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetBooksByCategoryEvent extends CategoryEvent {
  final int categoryId;
  final String? searchQuery;
  final String? rating;
  final int? year;
  const GetBooksByCategoryEvent(
    this.categoryId, {
    this.searchQuery,
    this.rating,
    this.year,
  });

  @override
  List<Object> get props => [categoryId];
}
