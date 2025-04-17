import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(context), body: Container());
  }
}

buildAppbar(BuildContext context) {
  return AppBar(
    title: const Text('Рукнлар'),
    centerTitle: true,
    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),

    backgroundColor: Theme.of(context).colorScheme.surface,
  );
  
}
