import 'package:collection/collection.dart';
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
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';

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
    context.read<ReservedBookBloc>().add(
      LoadReservedBooks(AppConfig.libraryId.toString()),
    );
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
              fontSize: 18.sp,
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
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookHeader(book: book),
                    SizedBox(height: 24.h),
                    SectionTitle(title: 'Қисқача'),
                    SizedBox(height: 8.h),
                    Text(
                      book.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(height: 24.h),
                    BlocListener<ReserveBookBloc, ReserveBookState>(
                      listener: (context, state) {
                        if (state is ReserveBookSuccess ||
                            state is CancelReservationSuccess) {
                          context.read<ReservedBookBloc>().add(
                            LoadReservedBooks(AppConfig.libraryId.toString()),
                          );
                        }
                      },
                      child: BlocBuilder<ReservedBookBloc, ReservedBookState>(
                        builder: (context, reservedState) {
                          if (reservedState is ReservedBookLoaded) {
                            final reservedBook = reservedState.books
                                .firstWhereOrNull(
                                  (e) => e.book.id == widget.book.id,
                                );

                            if (reservedBook != null &&
                                reservedBook.takenAt != null) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder:
                                    (child, animation) => FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                child:
                                    reservedBook.takenAt != null
                                        ? TextFieldInput(
                                          key: const ValueKey('takenAt'),
                                          label: "Олиб кетиш санаси",
                                          initialValue: reservedBook.takenAt!,
                                          readOnly: true,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ReserveBookBloc>()
                                                  .add(
                                                    CancelReservationRequested(
                                                      reservedBook.id,
                                                    ),
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.highlight_remove,
                                            ),
                                          ),
                                          onChanged: (_) {},
                                        )
                                        : !state.book.isAvailable
                                        ? PrimaryButton(
                                          key: const ValueKey('notAvailable'),
                                          onPressed: null,
                                          color: Colors.grey.shade400,
                                          child: Text(
                                            "Китоб қолмаган",
                                            style: TextStyle(
                                              color: AppColors().white
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        )
                                        : BlocBuilder<
                                          ReserveBookBloc,
                                          ReserveBookState
                                        >(
                                          builder: (context, reserveState) {
                                            final isLoading =
                                                reserveState
                                                    is ReserveBookLoading;

                                            return SizedBox(
                                              key: const ValueKey(
                                                'reserveButton',
                                              ),
                                              width: double.infinity,
                                              height: 48.h,
                                              child: PrimaryButton(
                                                onPressed:
                                                    isLoading
                                                        ? null
                                                        : () {
                                                          context
                                                              .read<
                                                                ReserveBookBloc
                                                              >()
                                                              .add(
                                                                ReserveBookRequested(
                                                                  widget
                                                                      .book
                                                                      .id,
                                                                ),
                                                              );
                                                        },
                                                child: AnimatedSwitcher(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  transitionBuilder:
                                                      (child, animation) =>
                                                          FadeTransition(
                                                            opacity: animation,
                                                            child: child,
                                                          ),
                                                  child:
                                                      isLoading
                                                          ? SizedBox(
                                                            key: const ValueKey(
                                                              "loading",
                                                            ),
                                                            height: 24.h,
                                                            width: 24.w,
                                                            child:
                                                                const CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                          )
                                                          : Text(
                                                            "Банд қилиш",
                                                            key: const ValueKey(
                                                              "text",
                                                            ),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              );
                            }

                            return BlocBuilder<
                              ReserveBookBloc,
                              ReserveBookState
                            >(
                              builder: (context, reserveState) {
                                final isLoading =
                                    reserveState is ReserveBookLoading;

                                return SizedBox(
                                  width: double.infinity,
                                  height: 48.h,
                                  child: PrimaryButton(
                                    onPressed:
                                        isLoading
                                            ? null
                                            : () {
                                              context
                                                  .read<ReserveBookBloc>()
                                                  .add(
                                                    ReserveBookRequested(
                                                      widget.book.id,
                                                    ),
                                                  );
                                            },
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      transitionBuilder:
                                          (child, animation) => FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                      child:
                                          isLoading
                                              ? SizedBox(
                                                key: const ValueKey("loading"),
                                                height: 24.h,
                                                width: 24.w,
                                                child:
                                                    const CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              )
                                              : Text(
                                                "Банд қилиш",
                                                key: const ValueKey("text"),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (reservedState is ReservedBookError) {
                            return Text("Хатолик: ${reservedState.message}");
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
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
