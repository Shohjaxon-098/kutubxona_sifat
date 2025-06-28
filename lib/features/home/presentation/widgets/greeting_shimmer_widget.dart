import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GreetingHeaderShimmer extends StatelessWidget {
  const GreetingHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed,
            highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 150.w, height: 16.h, color: Colors.white),
                SizedBox(height: 12.h),
                Container(width: 100.w, height: 16.h, color: Colors.white),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed,
            highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
            child: CircleAvatar(radius: 26.r, backgroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
