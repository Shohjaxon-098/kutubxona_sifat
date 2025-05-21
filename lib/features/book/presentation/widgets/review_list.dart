import 'package:kutubxona/export.dart';

class ReviewList extends StatelessWidget {
  final List reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          reviews.map((review) {
            final user = review.libraryMember!.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 25,
                    child:
                        user.photoUrl == null
                            ? Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: SvgPicture.asset(
                                AppImages().person,
                                width: 40,
                              ),
                            )
                            : null,
                    backgroundImage:
                        user.photoUrl == null
                            ? null
                            : CachedNetworkImageProvider(user.photoUrl),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: AppColors().border),
              ],
            );
          }).toList(),
    );
  }
}
