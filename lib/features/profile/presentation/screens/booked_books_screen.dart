import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_event.dart';
import 'package:kutubxona/features/profile/domain/entities/reserved_book_entity.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';
import 'package:kutubxona/features/widgets/no_field_widget.dart';

class BookedBooksPage extends StatefulWidget {
  final String libraryId;

  const BookedBooksPage({super.key, required this.libraryId});

  @override
  State<BookedBooksPage> createState() => _BookedBooksPageState();
}

class _BookedBooksPageState extends State<BookedBooksPage> {
  List<ReservedBookEntity>? books;
  void removeBook(int id) {
    setState(() {
      books?.removeWhere((book) => book.id == id);
      context.read<ReserveBookBloc>().add(CancelReservationRequested(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              sl<ReservedBookBloc>()..add(LoadReservedBooks(widget.libraryId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Банд қилинган китоблар')),
        body: BlocBuilder<ReservedBookBloc, ReservedBookState>(
          builder: (context, state) {
            if (state is ReservedBookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReservedBookLoaded) { 
              if (state.books == null || state.books.isEmpty) {
                return const Center(
                  child: NoDataWidget(
                    imagePath: 'assets/images/no-result.svg',
                    text: 'Банд клинган китоблар мавжуд емас',
                  ),
                ); // yoki NoDataWidget, sizda qanday nom bo'lsa
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
                      onPressed: () => removeBook(reservedBook.id),
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
        ),
      ),
    );
  }
}
