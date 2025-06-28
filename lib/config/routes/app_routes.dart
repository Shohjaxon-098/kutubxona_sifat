import 'package:flutter/foundation.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/screens/category_screen.dart';
import 'package:kutubxona/features/home/presentation/screens/home_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/booked_books_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/my_books_screen.dart';
import 'package:kutubxona/features/widgets/no_internet_widget.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String registerStep1Screen = '/registerStep1';
  static const String registerVerify = '/registerVerify';
  static const String onBoardScreen = '/onBoardScreen';
  static const String registerStep2Screen = '/registerStep2';
  static const String bookSearch = '/bookSearch';
  static const String categoryScreen = '/categoryScreen';
  static const String selectRegion = '/regionScreen';
  static const String bookDetail = '/bookDetail';
  static const String bookedBookScreen = '/bookedBookScreen';
  static const String myBookScreen = '/myBookScreen';
  static const String noInternetScreen = '/no-internet';
  static const String editProfile = '/editProfile';

  // Default transition settings
  static const _defaultDuration = Duration(milliseconds: 300);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildTransition(const SplashScreen(), PageTransitionType.fade);

      case noInternetScreen:
        return _buildTransition(
          const NoInternetScreen(),
          PageTransitionType.fade,
        );

      case home:
        return _buildTransition(const HomeScreen(), PageTransitionType.fade);

      case login:
        return _buildTransition(const Login(), PageTransitionType.rightToLeft);

      case registerStep1Screen:
        return _buildTransition(
          const RegisterStep1Screen(),
          PageTransitionType.rightToLeft,
        );

      case registerStep2Screen:
        return _buildTransition(
          const RegisterStep2Screen(),
          PageTransitionType.rightToLeft,
        );

      case registerVerify:
        return _buildTransition(
          const RegisterVerifyPage(),
          PageTransitionType.rightToLeft,
        );

      case onBoardScreen:
        return _buildTransition(
          const OnboardingScreen(),
          PageTransitionType.rightToLeft,
        );

      case selectRegion:
        return _buildTransition(
          SelectRegionScreen(),
          PageTransitionType.rightToLeft,
        );

      case categoryScreen:
        return _buildTransition(
          const CategoryScreen(),
          PageTransitionType.rightToLeft,
        );

      case bookedBookScreen:
        return _buildTransition(
          BookedBooksPage(libraryId: AppConfig.libraryId.toString()),
          PageTransitionType.rightToLeft,
        );

      case myBookScreen:
        return _buildTransition(
          const MyBooksScreen(),
          PageTransitionType.rightToLeft,
        );

      case editProfile:
        return _buildTransition(
          const EditProfileScreen(),
          PageTransitionType.rightToLeft,
        );

      default:
        return _errorRoute();
    }
  }

  /// Helper: standard transition
  static PageTransition _buildTransition(
    Widget child,
    PageTransitionType type,
  ) {
    return PageTransition(
      child: child,
      type: type,
      isIos: !kIsWeb && Platform.isIOS,
      duration: _defaultDuration,
      reverseDuration: _defaultDuration,
    );
  }

  /// Fallback for unknown routes
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
