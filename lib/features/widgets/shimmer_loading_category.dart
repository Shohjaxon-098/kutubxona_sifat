import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingAllCategories extends StatelessWidget {
  const ShimmerLoadingAllCategories({
    super.key,
    this.crossAxisCount = 3,
    this.itemHeight = 140,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
    this.itemCount = 6,
  });

  final int crossAxisCount;
  final double itemHeight;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.primaryFixed,
          highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
