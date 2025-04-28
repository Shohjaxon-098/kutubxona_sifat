
import 'package:kutubxona/core/constants/important.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  // Onboarding sahifalarining ma'lumotlari
  final List<Map<String, String>> pages = [
    {
      "image": AppImages().onBoard1,
      "text": "Китобларни уйингизга буюртма қилинг",
    },
    {
      "image": AppImages().onBoard2,
      "text": "Китобларни онлайн ўқинг",
    },
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
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          String image = pages[index]["image"]!;
          String text = pages[index]["text"]!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(image, height: 200),
                const SizedBox(height: 40),
                Text(
                  text,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? AppColors().enableDot
            : AppColors().disableDot,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Boshlash tugmasini qurish
  Widget _buildStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors().primaryColor,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SelectRegion()),
          );
        },
        child: Text(
          "Утказиб юбориш",
          style: TextStyle(color: AppColors().white),
        ),
      ),
    );
  }
}
