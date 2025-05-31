import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/screens/book_detail_screen.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_state.dart';
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

// TO‘G‘RILANGAN CATEGORY BOOKS SCREEN
class _CategoryBooksState extends State<CategoryBooks> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(
      GetBooksByCategoryEvent(widget.categoryId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            search(context: context),
            SizedBox(height: 25),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoadedState) {
                  final books = state.books;
                  if (books.isEmpty) {
                    return const Expanded(
                      child: NoDataWidget(
                        imagePath: 'assets/images/no-result.svg',
                        text: 'Сизнинг сўровингиз бўйича\n хечнарса топилмади!',
                      ),
                    );
                  }

                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: books.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.64,
                            crossAxisSpacing: 17,
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
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  width: 163,
                                  height: 209,
                                  child: CachedNetworkImage(
                                    imageUrl: book.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 9,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      book.category,
                                      style: TextStyle(
                                        color: AppColors().searchInDark,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages().rate,
                                          width: 15,
                                        ),
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
                      },
                    ),
                  );
                } else if (state is CategoryErrorState) {
                  return Center(child: Text('Xatolik: ${state.message}'));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSearch(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: search(context: context, enabled: true, onChanged: (query) {}),
      ),
      const SizedBox(width: 16),
      GestureDetector(
        onTap: () => showFilterModal(context),
        child: Icon(
          Icons.dashboard,
          color: Theme.of(context).colorScheme.scrim,
        ),
      ),
    ],
  );
}
