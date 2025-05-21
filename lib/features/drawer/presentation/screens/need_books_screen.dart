import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class NeedBooksScreen extends StatelessWidget {
  const NeedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          'Зарур китоблар',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBookGrid(),
      ),
    );
  }

  Widget _buildBookGrid() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const ShimmerLoadingSingleCategories();
        if (state is HomeError) return Center(child: Text(state.message));
        if (state is HomeDataLoaded) {
          return BooksGrid(books: state.books);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
