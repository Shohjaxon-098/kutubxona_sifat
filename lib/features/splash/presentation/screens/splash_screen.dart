import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/splash/presentation/widgets/splash_logo.dart';
import 'package:kutubxona/features/splash/presentation/widgets/splash_progress_bar.dart';
import 'package:kutubxona/features/splash/presentation/widgets/splash_text.dart';

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
      final userBox = Hive.box('userBox');
      final bool isRegistered = userBox.get(
        'isRegistered',
        defaultValue: false,
      );

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SplashLogo(),
            const SizedBox(height: 12),
            const SplashText(),
            const SizedBox(height: 150),
            SplashProgressBar(controller: _controller),
          ],
        ),
      ),
    );
  }
}
