import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class BookInfoTab extends StatelessWidget {
  final dynamic book;

  const BookInfoTab({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _field("ISBN", book.isbn, color),
        _field("Тил", book.language, color),
        _field("Сахифалар", book.pageCount.toString(), color),
      ],
    );
  }

  Widget _field(String title, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
