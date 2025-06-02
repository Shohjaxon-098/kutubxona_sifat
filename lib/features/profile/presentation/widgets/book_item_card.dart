import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/profile/data/model/my_book_model.dart';

class BookItemCard extends StatelessWidget {
  final BookUiModel book;

  const BookItemCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          book.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          book.author,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: List.generate(5, (i) {
            return SvgPicture.asset(
              AppImages().rate,
              height: 16,
              color: i < book.rating ? AppColors().rateColor : AppColors().grey,
            );
          }),
        ),
      ],
    );
  }
}
