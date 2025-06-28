import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/about_us_entity.dart';

class AboutUsCard extends StatelessWidget {
  const AboutUsCard({super.key, required this.info});
  final AboutUsEntity info;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(info.image),
          SizedBox(height: 18.h),
          _buildImage(info.image),
          SizedBox(height: 24.h),
          Text(
            info.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            info.description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CachedNetworkImage(
        imageUrl: url,
        height: 166.h,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
