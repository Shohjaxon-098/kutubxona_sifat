import 'package:flutter/material.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/signin/sign_in.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/signup/otp_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/signup/registration_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/signup/sign_up.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/home/screens/home_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/onboard/onboarding_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  // Define route names
  static const String splash = '/';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String otpScreen = '/otpScreen';
  static const String onBoardScreen = '/onBoardScreen';
  static const String register = '/register';
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
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
        );
      case signIn:
        return MaterialPageRoute(builder: (context) => SignIn());
      case signUp:
        return PageTransition(
          isIos: true,
          child: SignUp(),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 400),
        );
      case onBoardScreen:
        return PageTransition(
          isIos: true,
          child: OnboardingScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
        );
      case register:
        return PageTransition(
          isIos: true,
          child: AuthRegisterScreen(),
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
