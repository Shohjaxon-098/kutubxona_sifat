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
            Text('Куннинг енг яхшилари', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) return ShimmerLoadingSingleCategories();
            if (state is HomeDataLoaded) return SingleCategories(books: state.books);
            if (state is HomeError) return Center(child: Text(state.message));
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
