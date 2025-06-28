import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';

class FilterBottomSheet extends StatefulWidget {
  final int categoryId;
  final int? initialYear;
  final int? initialRating;

  const FilterBottomSheet({
    super.key,
    required this.categoryId,
    this.initialYear,
    this.initialRating,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedYear;
  int? selectedRating;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialYear;
    selectedRating = widget.initialRating;
  }

  void _applyFilter() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Navigator.of(
          context,
        ).pop({'year': selectedYear, 'rating': selectedRating});
      }
    });
    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(
        widget.categoryId,
        year: selectedYear,
        rating: selectedRating?.toString(),
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

    Future.delayed(Duration.zero, () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tune, size: 22.sp),
              SizedBox(width: 8.w),
              Text(
                "Китобларни саралаш",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 32.h),

          /// Year Filter
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().border),
              borderRadius: BorderRadius.circular(12.r),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Йил бўйича фильтер",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomDropdown(
                  hintText: 'Йилни танланг',
                  items: List.generate(8, (i) => (2020 + i).toString()),
                  selectedItem: selectedYear?.toString(),
                  onChanged: (value) {
                    if (value != null) {
                      final year = int.tryParse(value);
                      if (year != null) {
                        setState(() => selectedYear = year);
                      }
                    }
                  },
                ),
              ],
            ),
          ),

          /// Rating Filter
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().border),
              borderRadius: BorderRadius.circular(12.r),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Рейтинг бўйича фильтер",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 12.h),
                Column(
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final isSelected = selectedRating == rating;

                    return InkWell(
                      onTap: () {
                        setState(() => selectedRating = rating);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 12.w,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? theme.colorScheme.primary.withOpacity(0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
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
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Row(
                              children: List.generate(5, (i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  child: SvgPicture.asset(
                                    AppImages().rate,
                                    width: 20.w,
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

          SizedBox(height: 16.h),
          PrimaryButton(onPressed: _applyFilter, text: 'Натижаларни курсатиш'),
          SizedBox(height: 10.h),
          Center(
            child: TextButton(
              onPressed: _clearFilter,
              child: Text(
                'Фильтерни тозалаш',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
