import 'package:flutter/material.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/profile/data/model/booked_book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookedBooksPage extends StatefulWidget {
  const BookedBooksPage({super.key});

  @override
  State<BookedBooksPage> createState() => _BookedBooksPageState();
}

class _BookedBooksPageState extends State<BookedBooksPage> {
  List<Book> books = [
    Book(
      title: 'Стив Джобс',
      author: 'Жорж Оруел',
      imageUrl:
          'https://www.financialpipeline.com/app/uploads/2016/02/steve_jobs-400x400.jpg',
      rating: 4.5,
    ),
    Book(
      title: '1984',
      author: 'Жорж Оруел',
      imageUrl:
          'https://www.financialpipeline.com/app/uploads/2016/02/steve_jobs-400x400.jpg',
      rating: 4.8,
    ),
  ];

  void removeBook(Book book) {
    setState(() {
      books.remove(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Text(
          'Банд қилинган китоблар',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF7443),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Бу бўлимда сиз ўзингизга ёққан китобларни сақлашингиз мумкин",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/images/shelf.svg',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return _BookCard(
                    book: book,
                    onRemove: () => removeBook(book),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onRemove;

  const _BookCard({required this.book, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: book.imageUrl,
          width: 70,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        book.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 9),
          Row(
            children: List.generate(5, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: SvgPicture.asset(
                  AppImages().rate,
                  height: 16,
                  color:
                      i < book.rating ? const Color(0xffFF7F4D) : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            book.author,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/off_close.svg',
          width: 24,
          height: 24,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        onPressed: onRemove,
      ),
    );
  }
}
