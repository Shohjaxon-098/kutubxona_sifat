import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({
    super.key,
    required this.categories,
    this.crossAxisCount = 3,
    this.itemHeight = 140,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
  });

  final List<CategoryEntity> categories;
  final int crossAxisCount;
  final double itemHeight;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    final int rowCount = (categories.length / crossAxisCount).ceil();
    final double calculatedHeight =
        rowCount * itemHeight + (rowCount - 1) * mainAxisSpacing;

    return SizedBox(
      height: calculatedHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: 1, // yoki kerakli nisbatingiz
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: AppColors().cardColor),
              child: Center(
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors().white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
