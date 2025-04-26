import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_state.dart';

import 'package:kutubxona/features/kutubxona/presentation/home/filter_modal_trigger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool showDropdown = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() => showDropdown = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors().cardColor,
      body: Column(
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
                      child: SvgPicture.asset(AppImages().person, width: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          search(
                            focusNode: focusNode,
                            controller: controller,
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
                      ),
                    ),
                    if (showDropdown)
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return const LinearProgressIndicator();
                          } else if (state is HomeLoaded) {
                            final books = state.books;
                            if (books.isEmpty) {
                              return const Text("Hech qanday kitob topilmadi.");
                            }
                            return Container(
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
                            );
                          } else if (state is HomeError) {
                            return Text("Xatolik: ${state.message}");
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
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
                          const AllCategories(itemCount: 6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
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
                        ),
                        SizedBox(height: 12),
                        SingleCategories(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

buildBottomNavigationBar() {
  return BottomNavigationBar(items: []);
}
