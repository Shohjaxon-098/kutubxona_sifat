import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class CommentInputSection extends StatelessWidget {
  const CommentInputSection({super.key, required this.bookId});
  final int bookId;

  @override
  Widget build(BuildContext context) {
    int selectedRating = 0;
    final commentController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<PostReviewBloc, PostReviewState>(
      listener: (context, state) {
        if (state is PostReviewSuccess) {
          commentController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Фикр юборилди!")));
        } else if (state is PostReviewError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Хатолик: ${state.message}")));
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Китоб хақида фикрингиз",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            StarRating(onRatingChanged: (rating) => selectedRating = rating),
            const SizedBox(height: 16),
            Text(
              "Изох",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().border),
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: 'Изох',
                hintStyle: TextStyle(color: AppColors().hintColor),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
                child: PrimaryButton(
                  onPressed:
                      state is PostReviewLoading
                          ? null
                          : () {
                            final comment = commentController.text.trim();
                            if (comment.isNotEmpty && selectedRating > 0) {
                              context.read<PostReviewBloc>().add(
                                SubmitReview(
                                  ReviewRequestEntity(
                                    score: selectedRating.toString(),
                                    review: comment,
                                    bookId: bookId,
                                  ),
                                ),
                              );
                            }
                          },
                  ttext:
                      state is PostReviewLoading
                          ? const CircularProgressIndicator()
                          : Text(
                            "Юбориш",
                            style: TextStyle(color: AppColors().white),
                          ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
