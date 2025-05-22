import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ижтимоий тармоқлар',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _socialIcon('Facebook', iconColor),
            _socialIcon('YouTube', iconColor),
            _socialIcon('TikTok', iconColor),
            _socialIcon('Telegram', iconColor),
            _socialIcon('Instagram', iconColor),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String name, Color color) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      height: 28,
      width: 28,
      color: color,
    );
  }
}
