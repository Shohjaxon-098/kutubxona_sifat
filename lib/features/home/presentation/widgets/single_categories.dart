import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/screens/book_detail_screen.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class BooksGrid extends StatelessWidget {
  final List<BookEntity> books;
  final Axis scrollDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double height;
  final double mainAxisSpacing;

  const BooksGrid({
    super.key,
    required this.books,
    this.scrollDirection = Axis.vertical,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
    this.height = 250,
    this.mainAxisSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final grid = GridView.builder(
      scrollDirection: scrollDirection,
      physics:
          scrollDirection == Axis.horizontal
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: books.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing.h,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final book = books[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                isIos: true,
                child: BookDetailScreen(book: book),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 160.h,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: book.image,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                book.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                book.category,
                style: TextStyle(
                  color: AppColors().searchInDark,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImages().rate, width: 15.w),
                  SizedBox(width: 6.w),
                  Text(
                    book.rating ?? "0",
                    style: TextStyle(
                      color: AppColors().rateCount,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return scrollDirection == Axis.horizontal
        ? SizedBox(height: height.h, child: grid)
        : grid;
  }
}
