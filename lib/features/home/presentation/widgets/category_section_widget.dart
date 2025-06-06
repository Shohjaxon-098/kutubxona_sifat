import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/widgets/no_field_widget.dart';

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
            if (state is HomeDataLoaded) {
              if (state.categories.isEmpty) {
                return const NoDataWidget(
                  imagePath: 'assets/images/no-result.svg',
                  text: 'Сизнинг сўровингиз бўйича\n хечнарса топилмади!',
                );
              }
              return Categories(categories: state.categories, limitItems: true);
            }

            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
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
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () => AppNavigator.pushNamed(context, route),
          child: Text(
            'Барчаси',
            style: TextStyle(
              color: AppColors().blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
