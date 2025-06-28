import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailLoadingScreen extends StatelessWidget {
  const BookDetailLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildShimmerBox(width: 123.w, height: 158.h, context: context),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(
                      height: 20.h,
                      width: double.infinity,
                      context: context,
                    ),
                    SizedBox(height: 8.h),
                    _buildShimmerBox(
                      height: 16.h,
                      width: 150.w,
                      context: context,
                    ),
                    SizedBox(height: 8.h),
                    _buildShimmerBox(
                      height: 16.h,
                      width: 100.w,
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildShimmerBox(height: 16.h, width: 100.w, context: context),
          SizedBox(height: 8.h),
          _buildShimmerBox(
            height: 14.h,
            width: double.infinity,
            context: context,
          ),
          SizedBox(height: 24.h),
          _buildShimmerBox(
            height: 50.h,
            width: double.infinity,
            context: context,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.grey,
        ),
      ),
    );
  }
}
