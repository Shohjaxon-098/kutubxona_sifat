import 'package:flutter/material.dart';
import 'package:kutubxona/features/home/presentation/widgets/fileter_bottom_sheet.dart';

void showFilterModal(BuildContext context, int? categoryId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return FilterBottomSheet(categoryId: categoryId!);
    },
  );
}
