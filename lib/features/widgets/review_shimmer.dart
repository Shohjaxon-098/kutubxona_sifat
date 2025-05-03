import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 40, height: 40, color: Colors.white, margin: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10, width: double.infinity, color: Colors.white),
                      SizedBox(height: 6),
                      Container(height: 10, width: 150, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
