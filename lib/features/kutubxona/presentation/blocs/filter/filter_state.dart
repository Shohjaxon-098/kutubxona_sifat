import 'package:kutubxona/features/kutubxona/domain/entities/filter_entity.dart';


class FilterState {
  final FilterEntity filters;

  const FilterState({required this.filters});

  FilterState copyWith({FilterEntity? filters}) {
    return FilterState(filters: filters ?? this.filters);
  }
}
