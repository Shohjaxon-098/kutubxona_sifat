import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/core/util/formatters/phone_formatter.dart';
import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserProfileEntity user;

  const ProfileHeaderCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColors().primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 28,
              backgroundImage:
                  user.photoPath.isNotEmpty
                      ? CachedNetworkImageProvider(user.photoPath)
                      : null,
              child:
                  user.photoPath.isEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: SvgPicture.asset(AppImages().person, width: 40),
                      )
                      : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors().white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  FormatterUtil().formatPhoneNumber(user.phoneNumber),
                  style: TextStyle(fontSize: 12, color: AppColors().border),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
