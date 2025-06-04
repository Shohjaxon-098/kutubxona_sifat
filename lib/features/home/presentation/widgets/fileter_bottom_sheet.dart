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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppColors().border),
                  ),
                  title: Text(
                    "Йил бўйича",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  children: [
                    CustomDropdown(
                      hintText: '2000',
                      items: List.generate(8, (i) => (2020 + i).toString()),
                      selectedItem: filter.selectedYear,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<FilterBloc>().add(
                            SelectYearEvent(value),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Rating
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 24),
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppColors().border),
                  ),
                  title: Text(
                    "Рейтинг бўйича фильтер",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        final filterState = context.read<FilterBloc>().state;

                        context.read<HomeBloc>().add(
                          GetAllHomeDataEvent(
                            year: filterState.filters.selectedYear,
                            ratings: filterState.filters.selectedRatings,
                          ),
                        );

                        Navigator.of(context).pop(); // BottomSheet ni yopish
                      },
                      text: 'Қўллаш',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
