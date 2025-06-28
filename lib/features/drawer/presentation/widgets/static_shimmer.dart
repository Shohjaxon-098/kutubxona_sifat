import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class StatisticsShimmer extends StatelessWidget {
  const StatisticsShimmer({super.key});

  Widget _shimmerBox({
    required BuildContext context,
    double height = 16,
    double width = double.infinity,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        height: height.h,
        width: width == double.infinity ? double.infinity : width.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _shimmerCard(context: context, leftLabelWidth: 60, rightLabelWidth: 60),
        SizedBox(height: 16.h),
        _shimmerCard(
          context: context,
          leftLabelWidth: 120,
          rightLabelWidth: 140,
        ),
        SizedBox(height: 24.h),
        _shimmerStatsSection(context),
        SizedBox(height: 24.h),
        _shimmerStatsSection(context),
      ],
    );
  }

  Widget _shimmerCard({
    required BuildContext context,
    required double leftLabelWidth,
    required double rightLabelWidth,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(context: context, width: double.infinity, height: 50),
            SizedBox(height: 8.h),
            _shimmerBox(context: context, width: double.infinity, height: 50),
          ],
        ),
      ),
    );
  }

  Widget _shimmerStatsSection(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  _shimmerBox(context: context, width: 150, height: 50),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _shimmerBox(context: context, width: 30, height: 12),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
