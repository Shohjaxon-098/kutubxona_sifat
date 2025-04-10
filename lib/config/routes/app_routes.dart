import 'package:flutter/material.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/auth_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/otp_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/home/screens/home_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/onboard/onboarding_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  // Define route names
  static const String splash = '/';
  static const String home = '/home';
  static const String auth = '/signIn';
  static const String otpScreen = '/otpScreen';
  static const String onBoardScreen = '/onBoardScreen';

  // Method to handle routing
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
          isIos: true,
          child: SplashScreen(),
          type: PageTransitionType.fade,
        );
      case home:
        return PageTransition(
          isIos: true,
          child: HomeScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: Duration(milliseconds: 300),
        );
      case auth:
        return MaterialPageRoute(builder: (context) => AuthScreen());
      case onBoardScreen:
        return PageTransition(
          isIos: true,
          child: OnboardingScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
        );
      case otpScreen:
        return MaterialPageRoute(builder: (context) => OtpScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Page not found')),
          ),
    );
  }
}
