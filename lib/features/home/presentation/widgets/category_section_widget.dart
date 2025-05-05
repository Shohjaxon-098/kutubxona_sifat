import 'package:kutubxona/export.dart';

class CategorySectionWidget extends StatelessWidget {
  const CategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(context, 'Рукнлар', AppRoutes.categoryScreen),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) return ShimmerLoadingAllCategories();
            if (state is HomeDataLoaded) return AllCategories(categories: state.categories);
            if (state is HomeError) return Center(child: Text(state.message));
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title, String route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        GestureDetector(
          onTap: () => AppNavigator.pushNamed(context, route),
          child: Text('Барчаси', style: TextStyle(color: AppColors().blue, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
