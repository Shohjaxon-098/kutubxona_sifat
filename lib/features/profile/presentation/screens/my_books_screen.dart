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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            // Hisoblangan ratio
            final itemWidth = (screenWidth - 36) / 2; // padding + spacing
            final itemHeight = screenHeight * 0.38;
            final aspectRatio = itemWidth / itemHeight;

            return GridView.builder(
              physics: const BouncingScrollPhysics(),

              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio:
                    aspectRatio, // Bu muvozanatli ko‘rinish uchun yaxshi
              ),
              itemBuilder: (context, index) {
                return BookItemCard(book: books[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
