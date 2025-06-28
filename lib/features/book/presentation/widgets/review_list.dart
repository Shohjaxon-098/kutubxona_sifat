import 'package:kutubxona/export.dart';

class ReviewList extends StatelessWidget {
  final List reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Text(
          'Ҳеч қандай фикрлар йўқ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 15.sp,
          ),
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
          padding: EdgeInsets.only(bottom: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundImage:
                      user.photoUrl == null
                          ? null
                          : CachedNetworkImageProvider(user.photoUrl),
                  child:
                      user.photoUrl == null
                          ? Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: SvgPicture.asset(
                              AppImages().person,
                              width: 40.w,
                            ),
                          )
                          : null,
                ),
                title: Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                subtitle: Text(
                  DateFormat(
                    'yyyy.MM.dd',
                  ).format(DateTime.parse(review.createdAt)),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                review.review,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(color: AppColors().border),
            ],
          ),
        );
      },
    );
  }
}
