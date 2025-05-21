import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/book/domain/entities/review_request_entity.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_event.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_state.dart';
import 'package:kutubxona/features/widgets/primary_button.dart';
import 'package:kutubxona/features/widgets/star_reting.dart';

class CommentInputSection extends StatefulWidget {
  const CommentInputSection({super.key, required this.bookId});
  final int bookId;

  @override
  State<CommentInputSection> createState() => _CommentInputSectionState();
}

class _CommentInputSectionState extends State<CommentInputSection> {
  int selectedRating = 0;
  final commentController = TextEditingController();

  void _clearFields() {
    commentController.clear();
    setState(() {
      selectedRating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<PostReviewBloc, PostReviewState>(
      listener: (context, state) {
        if (state is PostReviewSuccess) {
          _clearFields(); // ⭐ Yuborilgandan keyin hammasi tozalanadi
          ToastMessage.showToast("Фикр юборилди", context);
        } else if (state is PostReviewError) {
          ToastMessage.showToast(state.message, context);
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
            StarRating(
              rating:
                  selectedRating, // ⭐ Qo‘shamiz: mavjud qiymatni ko‘rsatish uchun
              onRatingChanged:
                  (rating) => setState(() {
                    selectedRating = rating;
                  }),
            ),
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
                              bookId: widget.bookId,
                            );

                            if (review.review.isEmpty) {
                              ToastMessage.showToast(
                                "Илтимос, изоҳ киритинг",
                                context,
                              );
                            } else if (selectedRating == 0) {
                              ToastMessage.showToast(
                                "Илтимос, баҳо танланг",
                                context,
                              );
                            } else {
                              context.read<PostReviewBloc>().add(
                                SubmitReview(
                                  review: review,
                                  reviewBloc: context.read<ReviewBloc>(),
                                ),
                              );
                            }
                          },
                  ttext:
                      state is PostReviewLoading
                          ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
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
