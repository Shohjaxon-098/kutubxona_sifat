import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_bloc.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_event.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        final filter = state.filters;

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
              // Year
              ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors().border),
                ),
                title: Text(
                  "Йил бўйича",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                iconColor: Theme.of(context).colorScheme.tertiary,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 39,
                      top: 18,
                    ),
                    child: DropdownButtonFormField<String>(
                      iconDisabledColor: Theme.of(context).colorScheme.tertiary,
                      iconEnabledColor: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(16),
                      value: filter.selectedYear,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors().border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors().border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors().border),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColors().border),
                        ),
                      ),
                      hint: const Text(
                        "1900",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<FilterBloc>().add(
                            SelectYearEvent(value),
                          );
                        }
                      },
                      items:
                          List.generate(8, (i) => (1900 + i).toString())
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),

              // Rating
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ExpansionTile(
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppColors().border),
                  ),
                  title: Text(
                    "Рейтинг бўйича фильтер",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final selected = filter.selectedRatings.contains(rating);
                    return Row(
                      children: [
                        Checkbox(
                          activeColor: Theme.of(context).colorScheme.tertiary,
                          value: selected,
                          onChanged: (_) {
                            context.read<FilterBloc>().add(
                              ToggleRatingEvent(rating),
                            );
                          },
                        ),
                        Row(
                          children: List.generate(5, (i) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                i < rating
                                    ? Icons.star_rate_sharp
                                    : Icons.star_rate_outlined,
                                size: 35,
                                color:
                                    i < rating
                                        ? AppColors().rateColor
                                        : Colors.grey.shade300,
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  }),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: PrimaryButton(
                  onPressed:
                      () => context.read<FilterBloc>().add(ClearFiltersEvent()),
                  text: 'Тозалаш',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
