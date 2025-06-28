import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/info_row_widget.dart';

class BookCardStatistic extends StatelessWidget {
  final BookStatisticEntity book;

  const BookCardStatistic({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: 100.w,
                height: 165.h,
                color: Colors.grey.shade300,
                child: book.imageId == 0
                    ? Icon(Icons.book, size: 30.sp)
                    : CachedNetworkImage(
                        imageUrl: "", // TODO: Add real URL
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    book.author ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Roboto',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: '${book.publishedDate?.year ?? '—'}',
                  ),
                  SizedBox(height: 12.h),
                  InfoRow(
                    title: 'Жами брон қилинган:',
                    value: '${book.totalReservations}',
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
