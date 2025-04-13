import 'package:kutubxona/core/util/important.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(33),
                topRight: Radius.circular(33),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(color: AppColors().white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppNavigator.pushNamed(context, AppRoutes.bookSearch);
                        },
                        child: search(
                          enabled: false,
                          onChanged: (query) {
                            context.read<BookSearchBloc>().add(
                              SearchBooks(query),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 35),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Рукнлар',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
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

                          const AllCategories(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Куннинг енг яхшилари',
                                style: TextStyle(
                                  color: AppColors().black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const SingleCategories(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
