import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/screens/book_detail_screen.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_state.dart';
import 'package:kutubxona/features/category/presentation/widget/loading_category_book_widget.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/widgets/no_field_widget.dart';

class CategoryBooks extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryBooks({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryBooks> createState() => _CategoryBooksState();
}

class _CategoryBooksState extends State<CategoryBooks> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool showDropdown = false;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(widget.categoryId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Ekran kengligiga qarab crossAxisCount o‘zgartirish
    int crossAxisCount = 2;
    if (size.width >= 600) crossAxisCount = 3;
    if (size.width >= 900) crossAxisCount = 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: theme.colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.colorScheme.tertiary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Search va filter qatori
              _buildSearchRow(context),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoadingState) {
                      return const ShimmerLoadingCategoryBooks();
                    } else if (state is CategoryLoadedState) {
                      final books = state.books;

                      if (books.isEmpty) {
                        return const NoDataWidget(
                          imagePath: 'assets/images/no-result.svg',
                          text:
                              'Сизнинг сўровингиз бўйича\n хечнарса топилмади!',
                        );
                      }

                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 17,
                          childAspectRatio:
                              163 / 290, // kartaning kengligi/bo'yi
                        ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return BookCard(book: book);
                        },
                      );
                    } else if (state is CategoryErrorState) {
                      return Center(child: Text('Xatolik: ${state.message}'));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: search(
            context: context,
            enabled: true,
            onSubmitted: (query) {
              context.read<CategoryBloc>().add(
                GetBooksByCategoryEvent(widget.categoryId, searchQuery: query),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => showFilterModal(context, widget.categoryId),
          child: Icon(
            Icons.dashboard,
            color: Theme.of(context).colorScheme.scrim,
          ),
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
