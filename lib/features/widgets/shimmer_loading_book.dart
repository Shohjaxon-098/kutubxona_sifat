import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingSingleCategories extends StatelessWidget {
  const ShimmerLoadingSingleCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed,
            highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
            child: SizedBox(
              width: 140.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                      height: 160.h,
                      width: 140.w,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(height: 12.h, width: 100.w, color: Colors.white),
                  SizedBox(height: 6.h),
                  Container(height: 10.h, width: 80.w, color: Colors.white),
                  SizedBox(height: 6.h),
                  Container(height: 10.h, width: 40.w, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
