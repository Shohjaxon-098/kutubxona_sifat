import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/export.dart';

class RatingSummaryWidget extends StatelessWidget {
  final double averageRating;
  final Map<int, double> ratingPercentages; // Example: {5: 0.86, 4: 0.61, ...}

  const RatingSummaryWidget({
    super.key,
    required this.averageRating,
    required this.ratingPercentages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Рейтинг',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) {
            final star = 5 - index;
            final percent = (ratingPercentages[star] ?? 0);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages().rate, width: 16),
                  const SizedBox(width: 4),
                  Text('$star'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(12),
                      value: percent,
                      minHeight: 8,
                      backgroundColor: Color(0xffEEF4FF),
                      color: AppColors().primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(percent * 100).toInt()}%'),
                ],
              ),
            );
          }),
          const SizedBox(height: 20),
          Text(
            averageRating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          RatingBarIndicator(
            rating: averageRating,
            itemBuilder: (context, index) => SvgPicture.asset(AppImages().rate),
            itemCount: 5,
            itemSize: 26,
            unratedColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
