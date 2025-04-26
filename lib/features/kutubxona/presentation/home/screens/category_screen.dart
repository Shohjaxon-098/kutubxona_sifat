import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/filter_modal_trigger.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(context), body: buildBody(context));
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

Widget buildBody(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 11),
    child: Column(
      children: [
        buildSearch(context),
        const SizedBox(height: 24),
        const AllCategories(itemCount: 9, categories: []),
      ],
    ),
  );
}

Widget buildSearch(BuildContext context) {
  return Row(
    children: [
      search(context: context, enabled: true, onChanged: (query) {}),
      const SizedBox(width: 16),
      GestureDetector(
        onTap: () => showFilterModal(context),
        child: Icon(
          Icons.dashboard,
          color: Theme.of(context).colorScheme.scrim,
        ),
      ),
    ],
  );
}
