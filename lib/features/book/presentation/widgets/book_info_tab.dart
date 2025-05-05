import 'package:kutubxona/export.dart';

class BookInfoTab extends StatelessWidget {
  final dynamic book;

  const BookInfoTab({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.tertiary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _field("ISBN", book.isbn, color),
        _field("Тил", book.language, color),
        _field("Сахифалар", book.pageCount.toString(), color),
      ],
    );
  }

  Widget _field(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
