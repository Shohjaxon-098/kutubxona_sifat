import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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

    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(_delayDuration);

    final hasInternet = await InternetConnection().hasInternetAccess;

    if (!mounted) return;

    if (!hasInternet) {
      AppNavigator.pushReplacementNamed(context, AppRoutes.noInternetScreen);
      return;
    }

    final userBox = Hive.box('userBox');
    final bool isRegistered = userBox.get('isRegistered', defaultValue: false);

    if (isRegistered) {
      AppNavigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      AppNavigator.pushReplacementNamed(context, AppRoutes.onBoardScreen);
    }
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
            const SizedBox(height: 150),
            SplashProgressBar(controller: _controller),
          ],
        ),
      ),
    );
  }
}
