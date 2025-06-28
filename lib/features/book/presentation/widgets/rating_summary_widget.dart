import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kutubxona/export.dart';

class RatingSummaryWidget extends StatelessWidget {
  final double averageRating;
  final Map<int, double> ratingPercentages;

  const RatingSummaryWidget({
    super.key,
    required this.averageRating,
    required this.ratingPercentages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Рейтинг',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."',
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          ...List.generate(5, (index) {
            final star = 5 - index;
            final percent = (ratingPercentages[star] ?? 0);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages().rate, width: 16.w),
                  SizedBox(width: 4.w),
                  Text('$star', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(12.r),
                      value: percent,
                      minHeight: 8.h,
                      backgroundColor: const Color(0xffEEF4FF),
                      color: AppColors().primaryColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${(percent * 100).toInt()}%',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 20.h),
          Text(
            averageRating.toStringAsFixed(1),
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          RatingBarIndicator(
            rating: averageRating,
            itemBuilder: (context, index) => SvgPicture.asset(AppImages().rate),
            itemCount: 5,
            itemSize: 26.w,
            unratedColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
