import 'package:kutubxona/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const splashDuration = Duration(seconds: 3);
  static const delayDuration = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _navigateToNextScreen();
  }

  void _initAnimation() {
    _controller = AnimationController(duration: splashDuration, vsync: this)
      ..forward();
  }

  void _navigateToNextScreen() {
    Future.delayed(delayDuration, () async {
      // Simulate user authentication check or initialization here
      // final userData = await LocalStorage.getUserData();

      // if (userData != null) {
      //   Navigator.pushReplacementNamed(context, AppRoutes.home);
      // } else {
      //   Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      // }

      AppNavigator.pushReplacementNamed(context, AppRoutes.onBoardScreen);
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
            _buildSplashLogo(),
            const SizedBox(height: 8),
            _buildSplashText(),
            const SizedBox(height: 170),
            _buildProgressBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSplashLogo() {
    return Image.asset(AppImages().splashLogo, width: 140, height: 140);
  }

  Widget _buildSplashText() {
    return const Text(
      "Liber",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      width: 240,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return LinearProgressIndicator(
            borderRadius: BorderRadius.circular(5),
            value: _controller.value,
            backgroundColor: AppColors().linerBackgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors().linerValueColor,
            ),
          );
        },
      ),
    );
  }
}
