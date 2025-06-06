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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          const Center(
            child: Text(
              "Китоблар",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 50),

          // Year Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExpansionTile(
              title: Text(
                "Йил бўйича",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.tertiary,
                ),
              ),
              iconColor: theme.colorScheme.tertiary,
              children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ExpansionTile(
              title: Text(
                "Рейтинг бўйича фильтер",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.tertiary,
                ),
              ),
              iconColor: theme.colorScheme.tertiary,
              children: List.generate(5, (index) {
                final rating = 5 - index;
                final isSelected = selectedRating == rating;

                return Row(
                  children: [
                    Checkbox(
                      activeColor: theme.colorScheme.tertiary,
                      value: isSelected,
                      onChanged: (_) {
                        setState(() => selectedRating = rating);
                        _applyFilter();
                      },
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            AppImages().rate,
                            width: 30,
                            color:
                                i < rating
                                    ? AppColors().rateColor
                                    : AppColors().border,
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Clear Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryButton(onPressed: _clearFilter, text: 'Тозалаш'),
          ),
        ],
      ),
    );
  }
}
