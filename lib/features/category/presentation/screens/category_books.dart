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
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (width >= 600) crossAxisCount = 3;
    if (width >= 900) crossAxisCount = 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18.sp,
            color: theme.colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.colorScheme.tertiary),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearchRow(context),
            SizedBox(height: 20.h),
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
                        text: 'Сизнинг сўровингиз бўйича\n хечнарса топилмади!',
                      );
                    }

                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: books.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 17.w,
                        childAspectRatio: 163 / 290,
                      ),
                      itemBuilder:
                          (context, index) => BookCard(book: books[index]),
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
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () => showFilterModal(context, widget.categoryId),
          child: Image.asset(
            'assets/icons/filter.png',
            width: 24.w,
            height: 24.h,
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
            borderRadius: BorderRadius.circular(16.r),
            child: AspectRatio(
              aspectRatio: 163 / 209,
              child: CachedNetworkImage(
                imageUrl: book.image,
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) => Icon(
                      Icons.broken_image,
                      size: 60.sp,
                      color: Colors.grey[400],
                    ),
              ),
            ),
          ),
          SizedBox(height: 9.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  book.category,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors().searchInDark,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    SvgPicture.asset(AppImages().rate, width: 15.w),
                    SizedBox(width: 6.w),
                    Text(
                      book.rating ?? '0',
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
          ),
        ],
      ),
    );
  }
}
