import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DeficientLoadingWidget extends StatelessWidget {
  const DeficientLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder:
          (_, __) => Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryFixed,
            highlightColor: Theme.of(context).colorScheme.primaryFixedDim,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 164,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          4,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(height: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
