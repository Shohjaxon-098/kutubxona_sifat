import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/screens/booksearch_screen.dart';

class AppRoutes {
  // Define route names
  static const String splash = '/';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String otpScreen = '/otpScreen';
  static const String onBoardScreen = '/onBoardScreen';
  static const String register = '/register';
  static const bookSearch = '/bookSearch';
  // Method to handle routing
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
          isIos: true,
          child: const SplashScreen(),
          type: PageTransitionType.fade,
        );
      case home:
        return PageTransition(
          isIos: true,
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );
      case signIn:
        return MaterialPageRoute(builder: (context) => const Login());
      case signUp:
        return PageTransition(
          isIos: true,
          child: const SignUp(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case onBoardScreen:
        return PageTransition(
          isIos: true,
          child: const OnboardingScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );
      case register:
        return PageTransition(
          isIos: true,
          child: const AuthRegisterScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );
      case otpScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => TimerBloc(),
                child: const OtpScreen(),
              ),
        );
      case bookSearch:
        return PageTransition(
          isIos: true,
          child: const BookSearchScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 400),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
