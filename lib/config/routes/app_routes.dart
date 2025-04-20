import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/screens/category_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/screens/home_screen.dart';

class AppRoutes {
  // Define route names
  static const String splash = '/';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String registerStep1Screen = '/registerStep1';
  static const String registerVerify = '/registerVerify';
  static const String onBoardScreen = '/onBoardScreen';
  static const String registerStep2Screen = '/registerStep2';
  static const String bookSearch = '/bookSearch';
  static const String categoryScreen = '/categoryScreen';
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
      case registerStep1Screen:
        return PageTransition(
          isIos: true,
          child: const RegisterStep1Screen(),
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
      case registerStep2Screen:
        return PageTransition(
          isIos: true,
          child: const RegisterStep2Screen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );
      case registerVerify:
        return PageTransition(
          isIos: true,
          child: const RegisterVerify(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      // case bookSearch:
      //   return PageTransition(
      //     isIos: true,
      //     child: const BookSearchScreen(),
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 400),
      //   );
      case categoryScreen:
        return PageTransition(
          isIos: true,
          child: const CategoryScreen(),
          type: PageTransitionType.rightToLeft,
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
