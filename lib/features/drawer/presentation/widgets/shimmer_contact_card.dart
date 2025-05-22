import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            const SizedBox(height: 24),

            // Title placeholder
            Container(height: 20, width: 180, color: baseColor),
            const SizedBox(height: 24),

            // Info rows
            ...List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14, width: 100, color: baseColor),
                    const SizedBox(height: 4),
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: baseColor,
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Social title
            Container(height: 14, width: 140, color: baseColor),
            const SizedBox(height: 12),

            // Social icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    height: 32,
                    width: 32,
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
