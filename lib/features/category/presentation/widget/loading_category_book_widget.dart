import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingCategoryBooks extends StatelessWidget {
  const ShimmerLoadingCategoryBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    highlightColor:
                        Theme.of(context).colorScheme.primaryFixedDim,
                    child: Container(
                      width: 163,
                      height: 209,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).colorScheme.primaryFixed,
                        highlightColor:
                            Theme.of(context).colorScheme.primaryFixedDim,
                        child: Container(
                          width: 120,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).colorScheme.primaryFixed,
                        highlightColor:
                            Theme.of(context).colorScheme.primaryFixedDim,
                        child: Container(
                          width: 80,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).colorScheme.primaryFixed,
                        highlightColor:
                            Theme.of(context).colorScheme.primaryFixedDim,
                        child: Container(
                          width: 40,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
