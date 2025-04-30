import 'package:kutubxona/core/constants/important.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool showDropdown = false;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() => showDropdown = false);
      }
    });
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors().cardColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
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
                      Text(
                        'Ассалому алайкум!\nИсмоилбек',
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.clip,
                          color: AppColors().white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors().white,
                        radius: 28,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: SvgPicture.asset(
                            AppImages().person,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(33),
                      topRight: Radius.circular(33),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CompositedTransformTarget(
                                link: _layerLink,
                                child: search(
                                  focusNode: focusNode,
                                  controller: controller,
                                  context: context,
                                  enabled: true,
                                  onChanged: (query) {
                                    context.read<SearchBloc>().add(
                                      SearchQueryChanged(query),
                                    );
                                    if (query.isNotEmpty &&
                                        focusNode.hasFocus) {
                                      setState(() => showDropdown = true);
                                    } else {
                                      setState(() => showDropdown = false);
                                    }
                                  },
                                ),
                              ),
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
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
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
                            ),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoading) {
                                  return ShimmerLoadingAllCategories();
                                } else if (state is HomeDataLoaded) {
                                  return AllCategories(
                                    categories: state.categories,
                                  );
                                }
                                if (state is HomeError) {
                                  return Center(child: Text(state.message));
                                }
                                return Center(
                                  child: Text('Something went wrong.'),
                                );
                              },
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Куннинг енг яхшилари',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoading) {
                                  return ShimmerLoadingSingleCategories();
                                } else if (state is HomeDataLoaded) {
                                  return SingleCategories(books: state.books);
                                }
                                if (state is HomeError) {
                                  return Center(child: Text(state.message));
                                }
                                return Center(
                                  child: Text('Something went wrong.'),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (showDropdown)
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0.0, 50.0),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const LinearProgressIndicator();
                  } else if (state is SearchLoaded) {
                    final books = state.books;
                    if (books.isEmpty) {
                      return const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Hech qanday kitob topilmadi."),
                        ),
                      );
                    }
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return ListTile(
                              title: Text(book.name),
                              subtitle: Text(book.author),
                              onTap: () {
                                controller.text = book.name;
                                focusNode.unfocus();
                                setState(() => showDropdown = false);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is SearchError) {
                    return Card(child: Text("Xatolik: ${state.message}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
        ],
      ),
    );
  }
}

// buildBottomNavigationBar() {
//   return BottomNavigationBar(items: []);
// }
