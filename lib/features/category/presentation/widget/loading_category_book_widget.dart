import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoadingCategoryBooks extends StatelessWidget {
  const ShimmerLoadingCategoryBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // optional
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 17.w,
        childAspectRatio: 163 / 290,
      ),
      itemBuilder:
          (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.primaryFixed,
                  highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
                  child: Container(
                    width: double.infinity,
                    height: 209.h,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 120.w, height: 14.h),
                  SizedBox(height: 6.h),
                  ShimmerBox(width: 80.w, height: 12.h),
                  SizedBox(height: 6.h),
                  ShimmerBox(width: 40.w, height: 12.h),
                ],
              ),
            ],
          ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerBox({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(width: width, height: height, color: Colors.white),
    );
  }
}
