import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailLoadingScreen extends StatelessWidget {
  const BookDetailLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildShimmerBox(width: 123, height: 158, context: context),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(
                      height: 20,
                      width: double.infinity,
                      context: context,
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerBox(height: 16, width: 150, context: context),
                    const SizedBox(height: 8),
                    _buildShimmerBox(height: 16, width: 100, context: context),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildShimmerBox(height: 16, width: 100, context: context),
          const SizedBox(height: 8),
          _buildShimmerBox(
            height: 14,
            width: double.infinity,
            context: context,
          ),
          const SizedBox(height: 24),
          _buildShimmerBox(
            height: 50,
            width: double.infinity,
            context: context,
          ),
          const SizedBox(height: 24),
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
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
      ),
    );
  }
}
