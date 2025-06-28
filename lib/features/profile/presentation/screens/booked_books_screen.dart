import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_event.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_state.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';
import 'package:kutubxona/features/widgets/no_field_widget.dart';

class BookedBooksPage extends StatefulWidget {
  final String libraryId;

  const BookedBooksPage({super.key, required this.libraryId});

  @override
  State<BookedBooksPage> createState() => _BookedBooksPageState();
}

class _BookedBooksPageState extends State<BookedBooksPage> {
  void removeBook(int id) {
    context.read<ReserveBookBloc>().add(CancelReservationRequested(id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  sl<ReservedBookBloc>()
                    ..add(LoadReservedBooks(widget.libraryId)),
        ),
        BlocProvider(create: (_) => sl<ReserveBookBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Банд қилинган китоблар',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ReserveBookBloc, ReserveBookState>(
          listener: (context, state) {
            if (state is CancelReservationSuccess) {
              context.read<ReservedBookBloc>().add(
                LoadReservedBooks(widget.libraryId),
              );
              ToastMessage.showToast("Bandlik bekor qilindi", context);
            } else if (state is ReserveBookError) {
              ToastMessage.showToast(state.message, context);
            }
          },
          builder: (context, _) {
            return BlocBuilder<ReservedBookBloc, ReservedBookState>(
              builder: (context, state) {
                if (state is ReservedBookLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReservedBookLoaded) {
                  final bookedBooks =
                      state.books
                          .where((book) => book.status == 'booked')
                          .toList();

                  if (bookedBooks.isEmpty) {
                    return const Center(
                      child: NoDataWidget(
                        imagePath: 'assets/images/no-result.svg',
                        text: 'Банд қилинган китоблар мавжуд эмас',
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    itemCount: bookedBooks.length,
                    itemBuilder: (_, index) {
                      final reservedBook = bookedBooks[index];
                      final book = reservedBook.book;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 16.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImage(
                                imageUrl: book.image,
                                width: 100.w,
                                height: 100.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.name,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Row(
                                    children: List.generate(5, (i) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                        ),
                                        child: SvgPicture.asset(
                                          AppImages().rate,
                                          height: 16.h,
                                          color:
                                              i <
                                                      double.parse(
                                                        book.rating ?? '0',
                                                      )
                                                  ? AppColors().rateColor
                                                  : AppColors().grey,
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    book.author,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      letterSpacing: 0.15,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/off_close.svg',
                                width: 24.w,
                                height: 24.h,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              onPressed: () => removeBook(reservedBook.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is ReservedBookError) {
                  return Center(child: Text('Xatolik: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
