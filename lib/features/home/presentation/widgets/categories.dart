
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/screens/category_books.dart';
import 'package:kutubxona/features/home/domain/entities/category.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
    this.limitItems = false,
  });

  final List<CategoryEntity> categories;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final bool limitItems;

  @override
  Widget build(BuildContext context) {
    final displayCategories =
        limitItems ? categories.take(6).toList() : categories;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayCategories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = displayCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                isIos: true,
                child: CategoryBooks(
                  categoryId: category.id,
                  categoryName: category.name,
                ),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(category.icon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.45)),
                Padding(
                  padding: const EdgeInsets.all(16),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
