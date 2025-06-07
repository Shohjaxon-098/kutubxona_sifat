import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/info_row_widget.dart';

class BookCardStatistic extends StatelessWidget {
  final BookStatisticEntity book;

  const BookCardStatistic({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                height: 165,
                color: Colors.grey.shade300,
                child:
                    book.imageId == 0
                        ? const Icon(Icons.book, size: 30)
                        : CachedNetworkImage(
                          imageUrl: "",
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author!,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: '${book.publishedDate!.year}',
                  ),
                  const SizedBox(height: 12),
                  InfoRow(
                    title: 'Жами брон қилинган:',
                    value: book.totalReservations.toString(),
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
