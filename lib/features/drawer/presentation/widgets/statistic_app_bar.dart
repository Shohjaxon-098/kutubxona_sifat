import 'package:flutter/material.dart';

class StatisticAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatisticAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Statistikalar'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
