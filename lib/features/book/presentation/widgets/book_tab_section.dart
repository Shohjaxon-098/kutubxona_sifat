import 'package:flutter/material.dart';
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
        ),
        const SizedBox(height: 16),
        IndexedStack(
          index: currentTabIndex,
          children: [BookInfoTab(book: book), BookCommentTab(bookId: book.id)],
        ),
      ],
    );
  }
}