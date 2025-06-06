import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingCategoryBooks extends StatelessWidget {
  const ShimmerLoadingCategoryBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // optional
      shrinkWrap: true, // muhim!
      itemCount: 6, // 2 ta qator, 3 ta ustun (crossAxisCount = 2)
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 17,
        childAspectRatio: 163 / 290,
      ),
      itemBuilder:
          (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.primaryFixed,
                  highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
                  child: Container(
                    width: 200,
                    height: 250,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 120, height: 14),
                  const SizedBox(height: 6),
                  ShimmerBox(width: 80, height: 12),
                  const SizedBox(height: 6),
                  ShimmerBox(width: 40, height: 12),
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
