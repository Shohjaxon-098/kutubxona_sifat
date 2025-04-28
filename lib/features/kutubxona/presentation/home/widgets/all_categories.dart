import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({
    super.key,
    required this.categories,
    required this.itemCount,
  });

  final List<CategoryEntity>
  categories; // Expecting a list of Category objects.
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    double height = 250;

    return SizedBox(
      height: height,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            categories.length, // Use categories length instead of itemCount
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                // image: DecorationImage(image: NetworkImage(category.icon)),
                color: AppColors().cardColor,
              ),
              child: Center(
                child: Text(
                  category.name, // Use category name
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
