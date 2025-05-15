import 'package:flutter/material.dart';
import 'package:kutubxona/core/util/toast_message.dart';
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
          ToastMessage.showToast("Фикр юборилди");
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().border),
                  borderRadius: BorderRadius.circular(16),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().border),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
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
                            final review = ReviewRequestEntity(
                              score: selectedRating.toString(),
                              review: commentController.text.trim(),
                              bookId: bookId,
                            );
                            if (review.review.isNotEmpty && review.score != 0) {
                              context.read<PostReviewBloc>().add(
                                SubmitReview(
                                  review: review,
                                  reviewBloc:
                                      context
                                          .read<
                                            ReviewBloc
                                          >(), // bu orqali review qo‘shiladi
                                ),
                              );

                              commentController.clear(); // maydonni tozalash
                            }
                          },
                  ttext:
                      state is PostReviewLoading
                          ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors().white,
                          )
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
