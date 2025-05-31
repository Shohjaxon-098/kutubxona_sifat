import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class NeedBooksScreen extends StatelessWidget {
  const NeedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = List.generate(3, (_) => DummyBookData());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Зарур китоблар',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(book: book);
        },
      ),
    );
  }
}

class DummyBookData {
  final String title = 'Стив Джобс';
  final String author = 'Жорж Оруел';
  final String imageUrl = '';
  final int year = 2016;
  final int borrowed = 34;
  final int available = 23;
}

class BookCard extends StatelessWidget {
  final DummyBookData book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(width: 100, height: 164, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: book.year.toString(),
                  ),
                  InfoRow(
                    title: 'Банд қилинган китоблар:',
                    value: book.borrowed.toString(),
                  ),
                  InfoRow(
                    title: 'Мавжуд китоблар:',
                    value: book.available.toString(),
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
