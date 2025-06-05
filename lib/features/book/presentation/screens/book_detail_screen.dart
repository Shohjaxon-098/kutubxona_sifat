import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_event.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_state.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_event.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_state.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_event.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_state.dart';
import 'package:kutubxona/features/book/presentation/widgets/book_detail_loading.dart';
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
  String? takenAt;
  int? reservationId;

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
              fontSize: 18,
              fontFamily: 'Roboto',
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

                    Text(
                      book.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                    ),

                    const SizedBox(height: 24),
                    BlocConsumer<ReserveBookBloc, ReserveBookState>(
                      listener: (context, state) {
                        if (state is ReserveBookSuccess &&
                            state.reserveBook.book == widget.book.id) {
                          setState(() {
                            takenAt = state.reserveBook.takenAt;
                            reservationId = state.reserveBook.reservationId;
                          });
                          ToastMessage.showToast(
                            state.reserveBook.message.toString(),
                            context,
                          );
                        } else if (state is CancelReservationSuccess) {
                          setState(() {
                            takenAt = null;
                            reservationId = null;
                          });
                          ToastMessage.showToast(
                            "Bandlik bekor qilindi",
                            context,
                          );
                        } else if (state is ReserveBookError) {
                          ToastMessage.showToast(state.message, context);
                        }
                      },
                      builder: (context, state) {
                        if (state is ReserveBookLoading) {
                          return const CircularProgressIndicator();
                        }

                        final reservedBook =
                            state is ReserveBookSuccess
                                ? state.reserveBook
                                : null;

                        if (reservedBook != null &&
                            reservedBook.takenAt != null &&
                            reservedBook.book == widget.book.id) {
                          return TextFieldInput(
                            label: "Олиб кетиш санаси",
                            initialValue: reservedBook.takenAt!,
                            readOnly: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (reservedBook.reservationId != null) {
                                  context.read<ReserveBookBloc>().add(
                                    CancelReservationRequested(
                                      reservedBook.reservationId!,
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.highlight_remove),
                            ),
                            onChanged: (_) {},
                          );
                        }

                        return PrimaryButton(
                          onPressed: () {
                            context.read<ReserveBookBloc>().add(
                              ReserveBookRequested(book.id),
                            );
                          },
                          child: const Text(
                            "Банд қилиш",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
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
