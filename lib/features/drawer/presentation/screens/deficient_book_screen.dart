import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/presentation/logic/cubit/deficient_book_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/logic/cubit/deficient_book_state.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/book_card.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/deficient_loading.dart';

import 'package:kutubxona/features/widgets/no_field_widget.dart';

class DeficientBookScreen extends StatefulWidget {
  const DeficientBookScreen({super.key});

  @override
  State<DeficientBookScreen> createState() => _DeficientBookScreenState();
}

class _DeficientBookScreenState extends State<DeficientBookScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeficientBooksCubit>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: BlocBuilder<DeficientBooksCubit, DeficientBooksState>(
        builder: (context, state) {
          if (state is DeficientBooksLoading) {
            return DeficientLoadingWidget();
          } else if (state is DeficientBooksLoaded) {
            final books = state.books;
            if (books.isEmpty) {
              return Center(
                child: NoDataWidget(
                  text: 'Ҳозирча зарур китоблар мавжуд эмас',
                  imagePath:
                      'assets/images/no-result.svg', // Replace with your actual image path
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return BookCard(book: books[index]);
              },
            );
          } else if (state is DeficientBooksError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
