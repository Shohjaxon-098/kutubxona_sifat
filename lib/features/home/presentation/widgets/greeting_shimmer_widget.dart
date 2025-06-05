import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GreetingHeaderShimmer extends StatelessWidget {
  const GreetingHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
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
                Container(width: 150, height: 16, color: Colors.white),
                SizedBox(height: 12),
                Container(width: 100, height: 16, color: Colors.white),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed,
            highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
            child: CircleAvatar(radius: 26, backgroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
