import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/book_card_statistic.dart';

class BooksStatistic extends StatelessWidget {
  final String title;
  final List<BookStatisticEntity?> books;

  const BooksStatistic({super.key, required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 12.h),
        ...books.map(
          (book) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: BookCardStatistic(book: book!),
          ),
        ),
      ],
    );
  }
}
