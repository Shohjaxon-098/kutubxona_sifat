import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';
import 'package:kutubxona/features/profile/presentation/widgets/book_item_card.dart';
import 'package:kutubxona/features/widgets/no_field_widget.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  @override
  void initState() {
    context.read<ReservedBookBloc>().add(
      LoadReservedBooks(AppConfig.libraryId.toString()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Китобларим',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: BlocBuilder<ReservedBookBloc, ReservedBookState>(
        builder: (context, state) {
          if (state is ReservedBookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReservedBookLoaded) {
            final takenBooks =
                state.books
                    .where((book) => book.status == 'taken')
                    .map(
                      (book) => BookEntity(
                        name: book.book.name,
                        author: book.book.author,
                        image: book.book.image,
                        rating: book.book.rating ?? '0',
                        category: book.book.category,
                        id: book.book.id,
                        publication: book.book.publication,
                        slug: book.book.slug,
                        publishedDate: book.book.publishedDate,
                        reviewsCount: book.book.reviewsCount,
                      ),
                    )
                    .toList();

            if (takenBooks.isEmpty) {
              return const Center(
                child: NoDataWidget(
                  imagePath: 'assets/images/no-result.svg',
                  text: 'Олинган китоблар мавжуд эмас',
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.all(12.r),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (1.sw - 36.w) / 2;
                  final itemHeight = 0.38.sh;
                  final aspectRatio = itemWidth / itemHeight;

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: takenBooks.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: aspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      return BookItemCard(book: takenBooks[index]);
                    },
                  );
                },
              ),
            );
          } else if (state is ReservedBookError) {
            return Center(child: Text('Xatolik: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
