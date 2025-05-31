import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/domain/entities/review_entity.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_state.dart';
import 'package:kutubxona/features/book/presentation/widgets/comment_input_section.dart';
import 'package:kutubxona/features/book/presentation/widgets/rating_summary_widget.dart';
import 'package:kutubxona/features/book/presentation/widgets/review_list.dart';

class BookCommentTab extends StatelessWidget {
  const BookCommentTab({super.key, required this.bookId});
  final int bookId;

  double calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0.0;
    final validScores =
        reviews
            .map((r) => num.tryParse(r.score)?.toDouble())
            .where((s) => s != null)
            .cast<double>()
            .toList();

    if (validScores.isEmpty) return 0.0;

    final total = validScores.reduce((a, b) => a + b);
    return total / validScores.length;
  }

  Map<int, double> calculateRatingPercentages(List<ReviewEntity> reviews) {
    final total = reviews.length;
    if (total == 0) return {for (int i = 1; i <= 5; i++) i: 0.0};

    final Map<int, int> counts = {for (int i = 1; i <= 5; i++) i: 0};

    for (var review in reviews) {
      final scoreDouble = num.tryParse(review.score);
      if (scoreDouble != null) {
        final score = scoreDouble.toInt();
        if (counts.containsKey(score)) {
          counts[score] = counts[score]! + 1;
        }
      }
    }

    return {for (int i = 1; i <= 5; i++) i: counts[i]! / total};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return const SizedBox(); // yoki progress indicator
            } else if (state is ReviewLoaded) {
              final average = calculateAverageRating(state.reviews);
              final percentages = calculateRatingPercentages(state.reviews);
              return RatingSummaryWidget(
                averageRating: average,
                ratingPercentages: percentages,
              );
            }
            return const SizedBox(); // Error holatida siz xohlagancha qaytaring
          },
        ),
        const SizedBox(height: 16),
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
