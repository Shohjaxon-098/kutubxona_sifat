import 'package:kutubxona/export.dart';

class BookSectionWidget extends StatelessWidget {
  const BookSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Куннинг енг яхшилари',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 24),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading)
              return const ShimmerLoadingSingleCategories();
            if (state is HomeDataLoaded)
              return BooksGrid(
                books: state.books,
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: 1.9,
                height: 250,
                mainAxisSpacing: 17,
              );

            if (state is HomeError) return Center(child: Text(state.message));
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
