import 'package:flutter/material.dart';
import 'package:kutubxona/features/profile/data/model/my_book_model.dart';
import 'package:kutubxona/features/profile/presentation/widgets/book_item_card.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      BookUiModel(
        title: 'Стив Джобс',
        author: 'Жорж Оруел',
        imageUrl: 'https://yourdomain.com/steve_jobs.jpg',
        rating: 4,
      ),
      BookUiModel(
        title: 'Элжернонга аталган гуллар',
        author: 'Жорж Оруел',
        imageUrl: 'https://yourdomain.com/flowers.jpg',
        rating: 5,
      ),
      BookUiModel(
        title: '1984',
        author: 'Жорж Оруел',
        imageUrl: 'https://yourdomain.com/1984.jpg',
        rating: 5,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Китобларим',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.58, // Adjust aspect ratio as needed
          ),
          itemBuilder: (context, index) => BookItemCard(book: books[index]),
        ),
      ),
    );
  }
}
