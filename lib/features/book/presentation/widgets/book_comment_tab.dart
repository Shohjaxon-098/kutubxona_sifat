

import 'package:kutubxona/export.dart';

class BookCommentTab extends StatelessWidget {
  const BookCommentTab({super.key, required this.bookId});
  final int bookId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentInputSection(bookId: bookId),

        const SizedBox(height: 12),
        Divider(color: AppColors().border),
        Text(
          "Фикрлар",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return ReviewShimmer();
            } else if (state is ReviewLoaded) {
              return ReviewList(reviews: state.reviews);
            } else if (state is ReviewError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
