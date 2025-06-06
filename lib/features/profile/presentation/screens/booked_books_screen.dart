import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
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
          title: const Text(
            'Банд қилинган китоблар',
            style: TextStyle(
              fontSize: 18,
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
              // ❗ Kitob cancel bo‘ldi => ro‘yxatni yangilaymiz
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
                  if (state.books.isEmpty) {
                    return const Center(
                      child: NoDataWidget(
                        imagePath: 'assets/images/no-result.svg',
                        text: 'Банд қилинган китоблар мавжуд эмас',
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (_, index) {
                      final reservedBook = state.books[index];
                      final book = reservedBook.book;

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: book.image,
                            width: 96,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        trailing: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/off_close.svg',
                            width: 24,
                            height: 24,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onPressed: () {
                            context.read<ReserveBookBloc>().add(
                              CancelReservationRequested(reservedBook.id),
                            );
                          },
                        ),
                        title: Text(book.name),
                        subtitle: Text(book.author),
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
