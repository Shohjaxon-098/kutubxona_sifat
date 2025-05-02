import 'package:cached_network_image/cached_network_image.dart';
import 'package:kutubxona/core/util/important.dart';

import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/book/presentation/book_detail_screen.dart';

class SingleCategories extends StatelessWidget {
  const SingleCategories({super.key, required this.books});

  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 12,
          childAspectRatio: 1.9,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  isIos: true,
                  child: BookDetailScreen(bookId: book.id),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 160,
                    child: Card(
                      color: AppColors().cardColor,
                      child:
                      // ignore: unnecessary_null_comparison
                      CachedNetworkImage(
                        imageUrl: book.image,

                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        book.category,
                        style: TextStyle(
                          color: AppColors().searchInDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages().rate, width: 15),
                          const SizedBox(width: 6),
                          Text(
                            book.rating!.toStringAsFixed(1),
                            style: TextStyle(
                              color: AppColors().rateCount,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
