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
                SizedBox(height: 10.h),
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
            padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(page["image"]!, height: 200.h),
                SizedBox(height: 40.h),
                Text(
                  page["text"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20.sp,
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
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.pages.length,
          (index) => _dot(index, controller.currentIndex),
        ),
      ),
    );
  }

  Widget _dot(int index, int currentIndex) {
    final isActive = index == currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: isActive ? 16.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors().enableDot : AppColors().disableDot,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildButton(BuildContext context, OnboardingController controller) {
    final isLast = controller.currentIndex == controller.pages.length - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      child:
          isLast
              ? PrimaryButton(
                onPressed: controller.isLoading ? null : controller.startApp,
                child:
                    controller.isLoading
                        ? SizedBox(
                          height: 26.h,
                          width: 26.h,
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
                            fontSize: 16.sp,
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
                    fontSize: 16.sp,
                  ),
                ),
              ),
    );
  }
}
