import 'package:kutubxona/core/util/important.dart';

class FilterPanel extends StatefulWidget {
  final void Function(int? year)? onYearSelected;
  final void Function(double? rating)? onRatingSelected;

  const FilterPanel({super.key, this.onYearSelected, this.onRatingSelected});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  int? selectedYear;
  double? selectedRating;

  final List<int> years = [2025, 2024, 2023, 2022, 2021];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year Dropdown
        DropdownButtonFormField<int>(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors().border),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors().border),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors().border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors().border),
            ),
          ),
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          dropdownColor: AppColors().white,
          value: selectedYear,
          hint: const Text("Йил бўйича"),
          onChanged: (val) {
            setState(() => selectedYear = val);
            widget.onYearSelected?.call(val);
          },
          items:
              years
                  .map(
                    (y) =>
                        DropdownMenuItem(value: y, child: Text(y.toString())),
                  )
                  .toList(),
        ),
        const SizedBox(height: 16),

        // Rating Filter Title
        const Text(
          "Рейтинг бўйича фильтер",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        // Rating checkboxes with stars
        Column(
          children: List.generate(5, (index) {
            final rating = 5 - index;

            return Row(
              children: [
                Checkbox(
                  value: selectedRating == rating.toDouble(),
                  onChanged: (_) {
                    setState(() {
                      selectedRating = rating.toDouble();
                    });
                    widget.onRatingSelected?.call(rating.toDouble());
                  },
                ),
                Row(
                  children: List.generate(5, (starIndex) {
                    return Icon(
                      Icons.star,
                      color:
                          starIndex < rating ? Colors.orange : Colors.grey[300],
                    );
                  }),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
