import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/book_card_statistic.dart';

class BooksStatistic extends StatelessWidget {
  final String title;
  final List<BookStatisticEntity> books;

  const BooksStatistic({super.key, required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Text(
        '$title - маълумот йўқ',
        style: TextStyle(color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 12),
        ...books.map(
          (book) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookCardStatistic(book: book),
          ),
        ),
      ],
    );
  }
}
