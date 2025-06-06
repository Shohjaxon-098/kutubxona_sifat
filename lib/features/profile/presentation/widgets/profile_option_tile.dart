import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOptionTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  const ProfileOptionTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
