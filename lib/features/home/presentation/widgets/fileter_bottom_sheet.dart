// Presentation Layer – Filter Bottom Sheet
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';

class FilterBottomSheet extends StatefulWidget {
  final int categoryId;

  const FilterBottomSheet({super.key, required this.categoryId});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedYear;
  int? selectedRating;

  void _applyFilter() {
    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(
        widget.categoryId,
        year: selectedYear,
        rating: selectedRating != null ? selectedRating.toString() : null,
      ),
    );
  }

  void _clearFilter() {
    setState(() {
      selectedYear = null;
      selectedRating = null;
    });
    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(widget.categoryId),
    );
    // pop ni keyinchalik chaqirish
    Future.delayed(Duration.zero, () {
      if (mounted) return Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFilterApplied = selectedYear != null || selectedRating != null;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.tune),
              const SizedBox(width: 8),
              Text(
                "Китобларни саралаш",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // Year Filter
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().border),
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Йил бўйича фильтер",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                CustomDropdown(
                  hintText: 'Йилни танланг',
                  items: List.generate(8, (i) => (2020 + i).toString()),
                  selectedItem: selectedYear?.toString(),
                  onChanged: (value) {
                    if (value != null) {
                      final year = int.tryParse(value);
                      if (year != null) {
                        setState(() => selectedYear = year);
                        _applyFilter();
                      }
                    }
                  },
                ),
              ],
            ),
          ),

          // Rating Filter
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().border),
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Рейтинг бўйича фильтер",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final isSelected = selectedRating == rating;

                    return InkWell(
                      onTap: () {
                        setState(() => selectedRating = rating);
                        _applyFilter();
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? theme.colorScheme.primary.withOpacity(0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? theme.colorScheme.primary
                                    : AppColors().border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: List.generate(5, (i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  child: SvgPicture.asset(
                                    AppImages().rate,
                                    width: 24,
                                    color:
                                        i < rating
                                            ? AppColors().rateColor
                                            : AppColors().border,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          PrimaryButton(
            onPressed: isFilterApplied ? _clearFilter : null,
            text: 'Фильтерни тозалаш',
          ),
        ],
      ),
    );
  }
}
