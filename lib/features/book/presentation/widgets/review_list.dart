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
                    radius: 25,
                    backgroundImage: Image.network(user.photoUrl ?? '').image,
                    child:
                        user.photoUrl == null ? const Icon(Icons.person) : null,
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
