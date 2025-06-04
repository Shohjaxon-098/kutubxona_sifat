import 'package:provider/provider.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/onboard/presentation/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(context),
      child: Consumer<OnboardingController>(
        builder: (context, controller, _) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageView(controller),
                _buildDots(controller),
                const SizedBox(height: 10),
                _buildButton(context, controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageView(OnboardingController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.pages.length,
        physics: const BouncingScrollPhysics(),
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          final page = controller.pages[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(page["image"]!, height: 200),
                const SizedBox(height: 40),
                Text(
                  page["text"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDots(OnboardingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.pages.length,
        (index) => _dot(index, controller.currentIndex),
      ),
    );
  }

  Widget _dot(int index, int currentIndex) {
    final isActive = index == currentIndex;
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

  Widget _buildButton(BuildContext context, OnboardingController controller) {
    final isLast = controller.currentIndex == controller.pages.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child:
          isLast
              ? PrimaryButton(
                onPressed: controller.isLoading ? null : controller.startApp,
                child:
                    controller.isLoading
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
                          style: TextStyle(
                            color: AppColors().white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
              )
              : TextButton(
                onPressed: controller.goToLastPage,
                child: Text(
                  "Утказиб юбориш",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
    );
  }
}
