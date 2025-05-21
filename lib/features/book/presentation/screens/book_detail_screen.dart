import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/widgets/book_header.dart';
import 'package:kutubxona/features/book/presentation/widgets/book_tab_section.dart';
import 'package:kutubxona/features/book/presentation/widgets/section_title.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class BookDetailScreen extends StatefulWidget {
  final BookEntity book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _currentTabIndex = _tabController.index);
    });

    context.read<BookDetailBloc>().add(
      FetchBookDetail(AppConfig.libraryId.toString(), widget.book.slug),
    );

    context.read<ReviewBloc>().add(
      FetchReviews(
        libraryId: AppConfig.libraryId.toString(),
        slug: widget.book.slug,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostReviewBloc, PostReviewState>(
      listener: (context, state) {
        if (state is PostReviewSuccess) {
          context.read<ReviewBloc>().add(
            FetchReviews(
              libraryId: AppConfig.libraryId.toString(),
              slug: widget.book.slug,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          title: Text(
            "Китоб ҳақида",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BookDetailBloc, BookDetailState>(
          builder: (context, state) {
            if (state is BookDetailLoading) {
              return const BookDetailLoadingScreen();
            } else if (state is BookDetailLoaded) {
              final book = state.book;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookHeader(book: book),
                    const SizedBox(height: 24),
                    SectionTitle(title: 'Қисқача'),
                    const SizedBox(height: 8),
                    Text(book.description),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      onPressed: () {},
                      ttext: Text(
                        "Банд қилиш",
                        style: TextStyle(color: AppColors().white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BookTabSection(
                      book: book,
                      controller: _tabController,
                      currentTabIndex: _currentTabIndex,
                    ),
                  ],
                ),
              );
            } else if (state is BookDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
