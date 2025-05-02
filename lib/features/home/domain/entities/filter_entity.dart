class FilterEntity {
  final String? selectedYear;
  final List<int> selectedRatings;

  const FilterEntity({
    this.selectedYear,
    this.selectedRatings = const [],
  });

  FilterEntity copyWith({
    String? selectedYear,
    List<int>? selectedRatings,
  }) {
    return FilterEntity(
      selectedYear: selectedYear ?? this.selectedYear,
      selectedRatings: selectedRatings ?? this.selectedRatings,
    );
  }
}
