import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StatisticsShimmer extends StatelessWidget {
  const StatisticsShimmer({super.key});

  Widget _shimmerBox({
    required BuildContext context,
    double height = 16,
    double width = double.infinity,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stat Card 1 (Китобхонлар)
        _shimmerCard(context: context, leftLabelWidth: 60, rightLabelWidth: 60),
        const SizedBox(height: 16),

        // Stat Card 2 (Барча китоблар)
        _shimmerCard(
          context: context,
          leftLabelWidth: 120,
          rightLabelWidth: 140,
        ),
        const SizedBox(height: 24),

        // BooksStatisticsSection shimmer
        _shimmerStatsSection(context),
        const SizedBox(height: 24), _shimmerStatsSection(context),
      ],
    );
  }

  Widget _shimmerCard({
    required BuildContext context,
    required double leftLabelWidth,
    required double rightLabelWidth,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(context: context, width: double.infinity, height: 50),
            const SizedBox(height: 8),
            _shimmerBox(context: context, width: double.infinity, height: 50),
          ],
        ),
      ),
    );
  }

  Widget _shimmerStatsSection(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryFixed,
      highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  _shimmerBox(context: context, width: 150, height: 50),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _shimmerBox(context: context, width: 30, height: 12),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
