import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetBooksByCategoryEvent extends CategoryEvent {
  final int categoryId;

  const GetBooksByCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
