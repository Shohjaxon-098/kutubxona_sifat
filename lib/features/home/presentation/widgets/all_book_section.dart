import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/screens/book_detail_screen.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class AllBookSection extends StatelessWidget {
  const AllBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Китоблар',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 24),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading)
              return const ShimmerLoadingSingleCategories();
            if (state is HomeDataLoaded) {
              final books = state.books;
              return SizedBox(
                height: 350,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 17,
                    childAspectRatio: 163 / 290, // kartaning kengligi/bo'yi
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(book: book);
                  },
                ),
              );
            }
            if (state is HomeError) return Center(child: Text(state.message));
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class BookCard extends StatelessWidget {
  final BookEntity book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              // Bu childAspectRatio ga moslashadi
              aspectRatio: 163 / 209,
              child: CachedNetworkImage(
                imageUrl: book.image,
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) => Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey[400],
                    ),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  book.category,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors().searchInDark,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(AppImages().rate, width: 15),
                    const SizedBox(width: 6),
                    Text(
                      book.rating ?? '0',
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
  }
}
