import 'package:kutubxona/export.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(context), body: buildBody(context));
  }
}

buildAppbar(BuildContext context) {
  return AppBar(
    title: Text(
      'Рукнлар',
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w600,
      ),
    ),

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
        const SizedBox(height: 24),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return ShimmerLoadingAllCategories();
            } else if (state is HomeDataLoaded) {
              return Categories(
                categories: state.categories,
              ); // ❗ Bu yerda to‘liq ro‘yxat
            }
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Nimadir xato ketdi.'));
          },
        ),
      ],
    ),
  );
}
