import 'package:flutter/material.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';
import 'package:kutubxona/features/home/presentation/widgets/fileter_bottom_sheet.dart';

int? selectedYear;
int? selectedRating;

Future<void> showFilterModal(BuildContext context, int categoryId) async {
  final result = await showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (_) => FilterBottomSheet(
          categoryId: categoryId,
          initialYear: selectedYear,
          initialRating: selectedRating,
        ),
  );

  // Foydalanuvchi filterni saqlaganmi yoki bekor qilganmi tekshiramiz
  if (result != null) {
    selectedYear = result['year'] as int?;
    selectedRating = result['rating'] as int?;

    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(
        categoryId,
        year: selectedYear,
        rating: selectedRating?.toString(),
      ),
    );
  } else {
    // Filter tozalangan yoki modal yopilgan
    selectedYear = null;
    selectedRating = null;
  }
}
