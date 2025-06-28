import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContactCard extends StatelessWidget {
  const ShimmerContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.primaryFixed;
    final highlightColor = Theme.of(context).colorScheme.primaryFixedDim;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            SizedBox(height: 24.h),

            // Title placeholder
            Container(height: 20.h, width: 180.w, color: baseColor),
            SizedBox(height: 24.h),

            // Info rows
            ...List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14.h, width: 100.w, color: baseColor),
                    SizedBox(height: 4.h),
                    Container(
                      height: 16.h,
                      width: double.infinity,
                      color: baseColor,
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 24.h),

            // Social title
            Container(height: 14.h, width: 140.w, color: baseColor),
            SizedBox(height: 12.h),

            // Social icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Container(
                    height: 32.r,
                    width: 32.r,
                    decoration: BoxDecoration(
                      color: baseColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
