// features/book_detail/presentation/widgets/book_header.dart
import 'package:kutubxona/export.dart';

class BookHeader extends StatelessWidget {
  final dynamic book;

  const BookHeader({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            placeholder: (context, url) => ReviewShimmer(),
            imageUrl: book.image,
            width: 123,
            height: 158,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                book.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                book.author,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              _labelValue("Рукн:", book.category, context),
              const SizedBox(height: 5),
              _labelValue("Тил:", book.language, context),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            index < double.parse(book.rating)
                                ? Icons.star
                                : Icons.star_border,
                            size: 18,
                            color:
                                index < double.parse(book.rating)
                                    ? Colors.orange
                                    : Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(width: 6),
                  Text('${book.rating}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labelValue(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          value,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
