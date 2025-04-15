import 'package:flutter/material.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/onboard/screens/onboarding_screen.dart';
import 'package:kutubxona/service/hive_service.dart'; // HomeScreen import qilish

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    Future.delayed(const Duration(seconds: 4), () async {
      // // final userData = await LocalStorage.getUserData();

      // if (userData != null) {
      //   // oldin ro'yxatdan o'tgan foydalanuvchi
      //   Navigator.pushReplacementNamed(context, AppRoutes.home);
      // } else {

      // }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages().splashLogo, width: 140, height: 140),
            const SizedBox(height: 8),
            const Text(
              "Liber",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 170),
            SizedBox(
              width: 240,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(5),
                    value: _controller.value, // Animatsiyalashgan qiymat
                    backgroundColor: AppColors().linerBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors().linerValueColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
