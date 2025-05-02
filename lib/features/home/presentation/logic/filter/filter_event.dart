
abstract class FilterEvent {}

class SelectYearEvent extends FilterEvent {
  final String year;
  SelectYearEvent(this.year);
}

class ToggleRatingEvent extends FilterEvent {
  final int rating;
  ToggleRatingEvent(this.rating);
}

class ClearFiltersEvent extends FilterEvent {}
