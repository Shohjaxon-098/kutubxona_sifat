import 'package:kutubxona/core/util/important.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(getCategories: context.read<GetCategories>())..fetchCategories(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors().cardColor,
        body: Column(
          children: [
            _buildHeader(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors().cardColor,
          image: DecorationImage(
            image: AssetImage(AppImages().mask),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGreetingText(),
            _buildAvatar(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingText() {
    return Text(
      'Ассалому алайкум!\nИсмоилбек',
      style: TextStyle(
        fontSize: 20,
        overflow: TextOverflow.clip,
        color: AppColors().white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: AppColors().white,
      radius: 28,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: SvgPicture.asset(AppImages().person, width: 40),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _buildSearchAndFilter(context),
                    const SizedBox(height: 20),
                    _buildCategorySection(context, state.categories),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return Container();  // Default case
          },
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Row(
      children: [
        search(
          context: context,
          enabled: true,
          onChanged: (query) {},
        ),
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

  Widget _buildCategorySection(BuildContext context, List<Category> categories) {
    return Column(
      children: [
        _buildCategoryHeader(context),
        AllCategories(categories: categories),
      ],
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Рукнлар',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            AppNavigator.pushNamed(
              context,
              AppRoutes.categoryScreen,
            );
          },
          child: Text(
            'Барчаси',
            style: TextStyle(
              color: AppColors().blue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
