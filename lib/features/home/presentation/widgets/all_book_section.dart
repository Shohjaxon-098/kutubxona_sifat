import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/screens/category_books.dart';
class AllBookSection extends StatelessWidget {
  const AllBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const ShimmerLoadingSingleCategories();
        }
        if (state is HomeDataLoaded) {
          final books = state.books;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Китоблар',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 17,
                  childAspectRatio: 163 / 290,
                ),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BookCard(book: book),
                  );
                },
              ),
            ],
          );
        }
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
