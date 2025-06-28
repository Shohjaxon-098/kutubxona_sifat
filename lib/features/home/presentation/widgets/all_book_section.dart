import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              Text(
                'Китоблар',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 17.w,
                  childAspectRatio: 163.w / 290.h,
                ),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: BookCard(book: book),
                  );
                },
              ),
            ],
          );
        }

        if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
