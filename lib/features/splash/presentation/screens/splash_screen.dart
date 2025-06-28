import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/splash/presentation/widgets/splash_logo.dart';
import 'package:kutubxona/features/splash/presentation/widgets/splash_progress_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _splashDuration = Duration(seconds: 3);
  static const _delayDuration = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _splashDuration)
      ..forward();

    Future.delayed(_delayDuration, () {
      if (!mounted) return;

      final userBox = Hive.box('userBox');
      final bool isRegistered = userBox.get('isRegistered', defaultValue: false);

      if (isRegistered) {
        AppNavigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        AppNavigator.pushReplacementNamed(context, AppRoutes.onBoardScreen);
      }
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
      backgroundColor: AppColors().cardColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SplashLogo(),
            SizedBox(height: 150.h),
            SplashProgressBar(controller: _controller),
          ],
        ),
      ),
    );
  }
}
