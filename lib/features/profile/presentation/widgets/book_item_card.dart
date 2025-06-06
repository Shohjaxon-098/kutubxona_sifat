import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class BookItemCard extends StatelessWidget {
  final BookEntity book;

  const BookItemCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rasm (3:4 nisbat)
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.image,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Kitob nomi
          Text(
            book.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth < 360 ? 12 : 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Muallif
          Text(
            book.author,
            style: TextStyle(
              fontSize: screenWidth < 360 ? 10 : 12,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Reyting
          Row(
            children: List.generate(5, (i) {
              return Padding(
                padding: const EdgeInsets.only(right: 2),
                child: SvgPicture.asset(
                  AppImages().rate,
                  height: 16,
                  color:
                      i < double.parse(book.rating!)
                          ? AppColors().rateColor
                          : AppColors().grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
