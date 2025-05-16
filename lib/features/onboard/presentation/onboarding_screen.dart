import 'package:kutubxona/export.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool isLoading = false;

  // Onboarding sahifalarining ma'lumotlari
  final List<Map<String, String>> pages = [
    {
      "image": AppImages().onBoard1,
      "text": "Китобларни уйингизга буюртма қилинг",
    },
    {"image": AppImages().onBoard2, "text": "Китобларни онлайн ўқинг"},
    {
      "image": AppImages().onBoard3,
      "text": "Китобларни аудио шаклини тингланг",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageView(),
          _buildDotsIndicator(),
          const SizedBox(height: 10),
          _buildStartButton(context),
        ],
      ),
    );
  }

  // PageView uchun widget
  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        physics: const BouncingScrollPhysics(), // silliq scroll
        onPageChanged: (index) {
          if (currentIndex != index) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        itemBuilder: (context, index) {
          final page = pages[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  page["image"]!,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                Text(
                  page["text"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Dots indikatorni qurish
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pages.length, (index) => _buildDot(index)),
    );
  }

  // Bosilgan nuqtani qurish
  Widget _buildDot(int index) {
    bool isActive = currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors().enableDot : AppColors().disableDot,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Boshlash tugmasini qurish
  Widget _buildStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child:
          currentIndex == pages.length - 1
              ? PrimaryButton(
                onPressed:
                    isLoading
                        ? null
                        : () async {
                          setState(() {
                            isLoading = true;
                          });

                          // Ma'lumotni yuklash
                          context.read<LibraryBloc>().add(
                            FetchLibrariesEvent(),
                          );

                          // Kutish (sun'iy yoki BLoC bilan real yuklanishi tugaguncha kutish)
                          await Future.delayed(const Duration(seconds: 2));

                          // Sahifani almashtirish
                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const SelectRegionScreen(),
                              ),
                            );
                          }
                        },
                ttext:
                    isLoading
                        ? SizedBox(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors().white,
                          ),
                        )
                        : Text(
                          "Бошлаш",
                          style: TextStyle(color: AppColors().white),
                        ),
              )
              : TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    pages.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: const Text("Утказиб юбориш"),
              ),
    );
  }
}
