import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class BookHeader extends StatelessWidget {
  final dynamic book;

  const BookHeader({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CachedNetworkImage(
            imageUrl: book.image,
            width: 123.w,
            height: 158.h,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                Icon(Icons.broken_image, color: Colors.grey[400], size: 40.sp),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                book.author,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 5.h),
              _labelValue("Рукн:", book.category, context),
              SizedBox(height: 5.h),
              _labelValue("Тил:", book.language, context),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Icon(
                          index < double.parse(book.rating)
                              ? Icons.star
                              : Icons.star_border,
                          size: 18.sp,
                          color: index < double.parse(book.rating)
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${book.rating}',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labelValue(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            fontFamily: 'Roboto',
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
