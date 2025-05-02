import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class ShimmerLoadingSingleCategories extends StatelessWidget {
  const ShimmerLoadingSingleCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,

        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed, // light grey
            highlightColor:
                Theme.of(context).colorScheme.primaryFixedDim, // white-ish
            child: SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 160,
                      width: 140,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 100, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 10, width: 80, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 10, width: 40, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
