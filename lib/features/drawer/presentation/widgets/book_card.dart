import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';

class BookCard extends StatelessWidget {
  final DeficientBookEntity book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors().border),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: book.image,
                width: 100,
                height: 160,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(book.author),
                  const SizedBox(height: 8),
                  InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: book.publishedDate,
                  ),
                  InfoRow(
                    title: 'Банд қилинган китоблар:',
                    value: book.bookedCount.toString(),
                  ),
                  InfoRow(
                    title: 'Мавжуд китоблар:',
                    value: book.stock.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
