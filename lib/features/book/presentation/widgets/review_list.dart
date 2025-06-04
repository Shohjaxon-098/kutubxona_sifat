import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';

class ReviewList extends StatelessWidget {
  final List reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Text(
          'Ҳеч қандай фикрлар йўқ',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        final user = review.libraryMember!.user;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundImage:
                      user.photoUrl == null
                          ? null
                          : CachedNetworkImageProvider(user.photoUrl),
                  child:
                      user.photoUrl == null
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: SvgPicture.asset(
                              AppImages().person,
                              width: 40,
                            ),
                          )
                          : null,
                ),
                title: Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                subtitle: Text(
                  DateFormat(
                    'yyyy.MM.dd',
                  ).format(DateTime.parse(review.createdAt)),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                review.review,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors().border),
            ],
          ),
        );
      },
    );
  }
}
