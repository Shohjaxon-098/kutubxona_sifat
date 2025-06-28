import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/info_row_widget.dart';

class BookCard extends StatelessWidget {
  final DeficientBookEntity book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors().border),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: book.image,
                width: 100.w,
                height: 160.h,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'Roboto',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: book.publishedDate,
                  ),
                  SizedBox(height: 6.h),
                  InfoRow(
                    title: 'Банд қилинган китоблар:',
                    value: book.bookedCount.toString(),
                  ),
                  SizedBox(height: 6.h),
                  InfoRow(
                    title: 'Мавжуд китоблар:',
                    value: book.stock.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
