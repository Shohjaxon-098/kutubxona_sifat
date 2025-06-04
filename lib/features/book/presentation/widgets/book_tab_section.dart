import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/widgets/book_comment_tab.dart';
import 'package:kutubxona/features/book/presentation/widgets/book_info_tab.dart';

class BookTabSection extends StatelessWidget {
  final dynamic book;
  final TabController controller;
  final int currentTabIndex;

  const BookTabSection({
    super.key,
    required this.book,
    required this.controller,
    required this.currentTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          dividerColor: Colors.transparent,
          controller: controller,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 16),
          labelColor: textColor,
          unselectedLabelColor: Colors.grey,
          tabs: const [Tab(text: "Маълумотлар"), Tab(text: "Фикрлар")],
          onTap: (index) {
            if (index == 1) {
              // "Фикрлар" bosilganda alohida screenga o'tish
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  isIos: true,
                  duration: const Duration(milliseconds: 400),
                  child: BookCommentsScreen(bookId: book.id),
                ),
              );
              // Tabni yana 0 ga qaytarish uchun:
              controller.animateTo(0);
            }
          },
        ),
        const SizedBox(height: 16),
        // faqat Маълумотлар (info) ni ko'rsatamiz
        IndexedStack(index: 0, children: [BookInfoTab(book: book)]),
      ],
    );
  }
}
