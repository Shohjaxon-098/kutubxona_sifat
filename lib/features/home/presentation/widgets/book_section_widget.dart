import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class BookSectionWidget extends StatelessWidget {
  const BookSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Куннинг енг яхшилари',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 250.h, // bu balandlikni Column ichida cheklab beradi
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const ShimmerLoadingSingleCategories();
              }
              if (state is HomeDataLoaded) {
                return BooksGrid(
                  books: state.books,
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  childAspectRatio: 1.9,
                  mainAxisSpacing: 17.w,
                );
              }
              if (state is HomeError) {
                return Center(
                  child: Text(state.message, style: TextStyle(fontSize: 14.sp)),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
