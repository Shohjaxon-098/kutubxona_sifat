import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart'; // AppColors uchun kerak bo‘lsa

class BooksStatistic extends StatelessWidget {
  final String title;

  const BooksStatistic({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final books = List.generate(3, (_) => DummyBookData());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...books.map(
          (book) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookCardStatistic(book: book),
          ),
        ),
      ],
    );
  }
}

class DummyBookData {
  final String title;
  final String author;
  final String imageUrl;
  final int year;
  final int borrowed;
  final int available;

  DummyBookData({
    this.title = 'Стив Джобс',
    this.author = 'Жорж Оруел',
    this.imageUrl = '',
    this.year = 2016,
    this.available = 56,
    this.borrowed = 34,
  });
}

class BookCardStatistic extends StatelessWidget {
  final DummyBookData book;

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
                child: book.imageUrl.isEmpty
                    ? const Icon(Icons.book, size: 30)
                    : Image.network(book.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    title: 'Чоп қилинган йили:',
                    value: book.year.toString(),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    title: 'Банд қилинган китоблар:',
                    value: book.borrowed.toString(),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
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

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
